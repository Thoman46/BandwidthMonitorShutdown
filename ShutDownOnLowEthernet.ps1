# ============================
# LOAD USER CONFIGURATION
# ============================

# Path to the config file
$configPath = Join-Path -Path $PSScriptRoot -ChildPath "config.json"

if (Test-Path $configPath) {
    $config = Get-Content $configPath | ConvertFrom-Json
    $bandwidthThresholdBytes = $config.BandwidthThresholdKBps * 1KB
    $samplingIntervalSeconds = $config.SamplingIntervalSeconds
    $shutdownDelaySeconds = $config.ShutdownDelaySeconds
} else {
    Write-Warning "Config file not found. Using default settings."
    $bandwidthThresholdBytes = 200KB
    $samplingIntervalSeconds = 10
    $shutdownDelaySeconds = 60
}

# ============================
# INTERNAL CALCULATED VALUES
# ============================

# Number of samples needed based on delay and sampling interval (force to whole number)
$samplesRequired = [math]::Ceiling($shutdownDelaySeconds / $samplingIntervalSeconds)

# ============================
# FUNCTION DEFINITIONS
# ============================

# Function to calculate total bytes received per second across all network interfaces
function Get-TotalBytesReceivedPerSecond {
    $networkCounters = Get-Counter -Counter "\Network Interface(*)\Bytes Received/sec"
    $totalBytesReceived = 0

    foreach ($counter in $networkCounters.CounterSamples) {
        $totalBytesReceived += $counter.CookedValue
    }

    return [math]::Round($totalBytesReceived, 2)
}

# ============================
# INITIALIZATION
# ============================

# Array to store received bandwidth samples
$bandwidthSamples = @()

# Display startup message
Write-Host "Monitoring network bandwidth... System will shut down if average receive rate drops below $([math]::Round($bandwidthThresholdBytes / 1KB, 2)) KB/s for $shutdownDelaySeconds seconds." -ForegroundColor Cyan

# ============================
# MAIN MONITORING LOOP
# ============================

while ($true) {
    # Measure current received bandwidth
    $currentBandwidth = Get-TotalBytesReceivedPerSecond

    # Add the current sample to the collection
    $bandwidthSamples += $currentBandwidth

    # Limit the sample collection to only the most recent $samplesRequired entries
    if ($bandwidthSamples.Count -gt $samplesRequired) {
        $bandwidthSamples = $bandwidthSamples[-$samplesRequired..-1]
    }

    # Calculate the average bandwidth over the sample set
    $averageBandwidth = ($bandwidthSamples | Measure-Object -Average).Average

    # Display current average bandwidth
    if ($averageBandwidth -lt $bandwidthThresholdBytes) {
        Write-Host "Avg over last $($bandwidthSamples.Count * $samplingIntervalSeconds) sec: $([math]::Round($averageBandwidth / 1KB, 2)) KB/s [Below Threshold]" -ForegroundColor Yellow
    } else {
        Write-Host "Avg over last $($bandwidthSamples.Count * $samplingIntervalSeconds) sec: $([math]::Round($averageBandwidth / 1KB, 2)) KB/s"
    }

    # Check if shutdown criteria are met
    if ($bandwidthSamples.Count -eq $samplesRequired -and $averageBandwidth -lt $bandwidthThresholdBytes) {
        Write-Warning "Bandwidth average below threshold for designated monitoring window. Initiating shutdown..."
        # Uncomment below for testing without shutdown
        # Write-Host "[TEST MODE] Shutdown would be triggered here."

        # Shut down the system
        Stop-Computer -Force
        break
    }

    # Wait before taking the next measurement
    Start-Sleep -Seconds $samplingIntervalSeconds
}

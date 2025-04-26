# Bandwidth Monitor and Automatic Shutdown

This project monitors the network bandwidth of your computer. If the **average received bandwidth** drops below a set threshold for a defined period of time, the system will **automatically shut down**.

## 🚀 Features
- Continuously monitors total received bandwidth across all network interfaces.
- Shuts down the computer if bandwidth stays below the threshold for the specified duration.
- Simple and configurable via user-editable variables.
- Includes an easy-to-use batch launcher.

## 🛠️ Files
- `ShutdownOnLowEthernet.ps1` — PowerShell script that monitors bandwidth and shuts down the system.
- `RunBandwidthMonitor.bat` — Batch file to easily launch the PowerShell script.

## ⚙️ Configuration
Edit the `config.json` file to change settings:

| Variable | Description |
|----------|-------------|
| `BandwidthThresholdKBps` | Bandwidth threshold (default: 200KB/s) |
| `SamplingIntervalSeconds` | How often to sample bandwidth (default: 10 seconds) |
| `ShutdownDelaySeconds` | How long the bandwidth must stay below threshold before shutdown (default: 60 seconds) |

## 📋 Requirements
- Windows operating system
- PowerShell installed (comes by default on Windows 10/11)
- Administrator privileges (required to perform system shutdown)

## 📦 How to Use
1. Clone or download this repository.
2. Modify `ShutdownOnLowEthernet.ps1` if you want to change the settings.
3. Run `RunBandwidthMonitor.bat` to start monitoring.

> **Tip:** You can add the batch file to your Windows startup folder to monitor automatically at boot!

## ⚖️ License
This project is licensed under the [MIT License](LICENSE).
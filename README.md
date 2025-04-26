# Bandwidth Monitor and Automatic Shutdown

This project monitors the network bandwidth of your computer. If the **average received bandwidth** drops below a set threshold for a defined period of time, the system will **automatically shut down**.

## 🚀 Features
- Continuously monitors total received bandwidth across all network interfaces.
- Shuts down the computer if bandwidth stays below the threshold for the specified duration.
- Editable configuration file to set your own parameters.
- Testing mode to simulate shutdown without actually turning off the computer (TestMode is on by default).
- Includes an easy-to-use batch launcher.

## 🛠️ Files
- `ShutdownOnLowEthernet.ps1` — PowerShell script that monitors bandwidth and shuts down the system.
- `RunBandwidthMonitor.bat` — Batch file to easily launch the PowerShell script.
- `config.json` — User-editable settings file.

## ⚙️ Configuration
Edit the `config.json` file to change settings:

| Variable                  | Description                                                                            |
| ------------------------- | -------------------------------------------------------------------------------------- |
| `BandwidthThresholdKBps`  | Bandwidth threshold (default: 200KB/s)                                                 |
| `SamplingIntervalSeconds` | How often to sample bandwidth (default: 10 seconds)                                    |
| `ShutdownDelaySeconds`    | How long the bandwidth must stay below threshold before shutdown (default: 60 seconds) |
| `TestingMode`             | If true, the script will not shut down the system (default: true)                      |

## 📋 Requirements
- Windows operating system
- PowerShell installed (comes by default on Windows 10/11)
- Administrator privileges (required to perform system shutdown)

## 📦 How to Use
1. Clone or download this repository.
2. Modify `config.json` if you want to change the settings.
3. Run `RunBandwidthMonitor.bat` to start monitoring.
4. After the specified duration of low bandwidth, the system will shut down automatically.

## ⚖️ License
This project is licensed under the [MIT License](LICENSE).
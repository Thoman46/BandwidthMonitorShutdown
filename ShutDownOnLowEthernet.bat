@echo off
setlocal

:: ============================
:: Configuration Section
:: ============================

:: Define the path to the PowerShell script (located in the same directory as the batch file)
set SCRIPT_PATH=%~dp0ShutDownOnLowEthernet.ps1

:: ============================
:: Execution Section
:: ============================

:: Run the PowerShell script with unrestricted execution policy and no user profile loaded
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"

:: ============================
:: Cleanup Section
:: ============================

endlocal

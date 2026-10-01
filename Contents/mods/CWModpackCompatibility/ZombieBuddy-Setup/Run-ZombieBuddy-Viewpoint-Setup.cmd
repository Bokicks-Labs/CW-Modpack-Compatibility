@echo off
setlocal
title Chaosworld ZombieBuddy and Viewpoint Setup
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Setup-ZombieBuddyForViewpoint.ps1" -Action Install -LaunchOfficialInstaller
set "CW_ZB_EXIT=%ERRORLEVEL%"
echo.
if not "%CW_ZB_EXIT%"=="0" echo Setup stopped with exit code %CW_ZB_EXIT%. Review the message above; no trust policy or save data was changed.
pause
exit /b %CW_ZB_EXIT%

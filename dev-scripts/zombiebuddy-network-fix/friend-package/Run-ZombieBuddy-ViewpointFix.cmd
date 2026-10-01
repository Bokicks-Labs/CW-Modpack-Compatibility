@echo off
setlocal
title ZombieBuddy 42.21 Viewpoint Fix
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-ZombieBuddy-ViewpointFix.ps1" -Action Install
set "ZB_FIX_EXIT=%ERRORLEVEL%"
echo.
if not "%ZB_FIX_EXIT%"=="0" echo Setup stopped with exit code %ZB_FIX_EXIT%.
pause
exit /b %ZB_FIX_EXIT%

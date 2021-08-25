@echo off
set currdir=%~dp0
IF "%currdir:~-1%"=="\" SET currdir=%currdir:~0,-1%
cd /d "%currdir%"

C:\influxdb\nssm stop influxdb
C:\influxdb\nssm remove influxdb confirm

:END
echo bye
timeout /t 5
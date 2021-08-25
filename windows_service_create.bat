@echo off
set currdir=%~dp0
IF "%currdir:~-1%"=="\" SET currdir=%currdir:~0,-1%
cd /d "%currdir%"

C:\influxdb\nssm install influxdb "influxd"
C:\influxdb\nssm set influxdb AppDirectory "C:\influxdb"
C:\influxdb\nssm set influxdb AppParameters "-config influxdb.conf"
C:\influxdb\nssm start influxdb

:END
echo bye
timeout /t 5
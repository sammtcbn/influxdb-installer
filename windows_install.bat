@echo off
set currdir=%~dp0
IF "%currdir:~-1%"=="\" SET currdir=%currdir:~0,-1%
cd /d "%currdir%"

mkdir C:\influxdb

copy /Y "%currdir%\win_service_create.bat" C:\influxdb
copy /Y "%currdir%\win_service_delete.bat" C:\influxdb
copy /Y "%currdir%\nssm.exe" C:\influxdb
xcopy /Y "%currdir%\influxdb\*.*" C:\influxdb

:END
echo bye
timeout /t 5
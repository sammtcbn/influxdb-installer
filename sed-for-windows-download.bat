@echo off
set currdir=%~dp0
IF "%currdir:~-1%"=="\" SET currdir=%currdir:~0,-1%
cd /d "%currdir%"

curl --fail --output sed.zip -L http://gnuwin32.sourceforge.net/downlinks/sed-bin-zip.php
if %errorlevel% neq 0 (
    echo Fail to download sed.zip
    pause
    goto End
)

curl --fail --output regex.zip -L http://gnuwin32.sourceforge.net/downlinks/regex-bin-zip.php
if %errorlevel% neq 0 (
    echo Fail to download regex.zip
    pause
    goto End
)

curl --fail --output libintl.zip -L http://gnuwin32.sourceforge.net/downlinks/libintl-bin-zip.php
if %errorlevel% neq 0 (
    echo Fail to download libintl.zip
    pause
    goto End
)

curl --fail --output libiconv.zip -L http://gnuwin32.sourceforge.net/downlinks/libiconv-bin-zip.php
if %errorlevel% neq 0 (
    echo Fail to download libiconv.zip
    pause
    goto End
)

powershell -command "Expand-Archive -Force sed.zip .\sedtmp"
powershell -command "Expand-Archive -Force regex.zip .\sedtmp"
powershell -command "Expand-Archive -Force libintl.zip .\sedtmp"
powershell -command "Expand-Archive -Force libiconv.zip .\sedtmp"

copy /Y .\sedtmp\bin\* "%currdir%"

rmdir /s /q .\sedtmp
del /f /q sed.zip regex.zip libintl.zip libiconv.zip

:END
echo bye
timeout /t 5
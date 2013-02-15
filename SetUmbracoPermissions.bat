@echo off
set /p UserAppPoolName= Please enter the Application Pool Name you would like to grant permission?

REM Following line in original script incorrectly sets all child folder permissions
REM icacls . /grant %UserAppPoolName%:(OI)(CI)M
icacls .sass-cache /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls app_browsers /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls app_code /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls app_data /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls app_plugins /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls bin /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)R
icacls config /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls css /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls data /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls fonts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls images /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls js /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls macroscripts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls masterpages /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls media /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls sass /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls scripts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls stylesheets /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls umbraco /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls usercontrols /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)R
icacls xslt /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls views /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls web.config /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls web.config /grant "IIS APPPOOL\%UserAppPoolName%":M
REM If you have installed the Robots.txt editor package you need the following line too
SET /P ANSWER=Do you have the Robots.txt editor package installed? (Y/N)?
if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)
goto :no
:yes
icacls robots.txt /grant %UserAppPoolName%:M
PAUSE
exit /b 0

:no
PAUSE
exit /b 1

@echo off
set /p UserAppPoolName= Please enter the Application Pool Name you would like to grant permission?

REM Following line in original script incorrectly sets all child folder permissions
REM icacls . /grant %UserAppPoolName%:(OI)(CI)M
icacls %1\app_browsers /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls %1\app_code /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls %1\app_data /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\app_plugins /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\bin /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)R
icacls %1\config /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\css /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\data /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\fonts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls %1\images /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\macroscripts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\masterpages /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\media /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\scripts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\umbraco /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\usercontrols /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)R
icacls %1\xslt /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\views /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\web.config /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\web.config /grant "IIS APPPOOL\%UserAppPoolName%":M
REM If you have installed the Robots.txt editor package you need the following line too
SET /P ANSWER=Do you have the Robots.txt editor package installed? (Y/N)?
if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)
goto :no
:yes
icacls robots.txt /grant "IIS APPPOOL\%UserAppPoolName%":M
PAUSE
exit /b 0

:no
PAUSE
exit /b 1

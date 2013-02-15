@echo off
set /p UserAppPoolName= Please enter the Application Pool Name you would like to grant permission?

REM Following line in original script incorrectly sets all child folder permissions
REM icacls %1\. /grant %UserAppPoolName%:(OI)(CI)M
icacls %1\app_browsers /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls %1\app_code /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls %1\app_data /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\app_plugins /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\bin /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)R
icacls %1\config /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\data /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\fonts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)RX
icacls %1\images /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\masterpages /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\media /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\umbraco /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\usercontrols /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)R
icacls %1\xslt /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\web.config /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\web.config /grant "IIS APPPOOL\%UserAppPoolName%":M

REM If you are using MVC in Umbraco 4.x.y then you need the following action:
SET /P MODEL=Are you using MVC in Umbraco 4.x.y or greater? (Y/N)?
if /i {%MODEL%}=={y} (goto :yes-model)
if /i {%MODEL%}=={yes} (goto :yes-model)
goto :no-model

:yes-model
icacls %1\macroscripts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
icacls %1\views /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
goto :styling

:no-model
icacls %1\python /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
goto :styling

:styling
REM If you have renamed your stylesheet directory you need the following action:
SET /P STYLES=Have you changed your stylesheet directory location? (Y/N)?
if /i {%STYLES%}=={y} (goto :yes-styles)
if /i {%STYLES%}=={yes} (goto :yes-styles)
goto :no-styles

:yes-styles
SET /P DIR=Please enter the name for your stylesheet directory:
icacls %1\%DIR% /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
goto :scripting

:no-styles
icacls %1\css /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
goto :scripting

:scripting
REM If you have renamed your javascript directory you need the following action:
SET /P SCRIPTS=Have you changed your javascript directory location? (Y/N)?
if /i {%SCRIPTS%}=={y} (goto :yes-scripts)
if /i {%SCRIPTS%}=={yes} (goto :yes-scripts)
goto :no-scripts

:yes-scripts
SET /P DIR=Please enter the name for your scripts directory:
icacls %1\%DIR% /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
goto :robots

:no-scripts
icacls %1\scripts /grant "IIS APPPOOL\%UserAppPoolName%":(OI)(CI)M
goto :robots

:robots
REM If you have installed the Robots.txt editor package you need the following line too
SET /P ANSWER=Do you have the Robots.txt editor package installed? (Y/N)?
if /i {%ANSWER%}=={y} (goto :yes-robots)
if /i {%ANSWER%}=={yes} (goto :yes-robots)
goto :no-robots

:yes-robots
icacls %1\robots.txt /grant "IIS APPPOOL\%UserAppPoolName%":M
goto :end

:no-robots
goto :end

:end
PAUSE


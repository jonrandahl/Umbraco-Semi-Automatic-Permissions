@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
:: SetUmbracoPermissions

SET /P W2K8=Are you hosting Umbraco on Windows Server 2008 or newer? (Y/N)?
if /i {%W2K8%}=={y} (goto :yes-w2k8)
if /i {%W2K8%}=={yes} (goto :yes-w2k8)
goto :no-w2k8

:yes-w2k8
SET /P UserAppPoolName= Please enter the Application Pool Name you would like to grant permission?
SET AccessUserName=IIS APPPOOL\%UserAppPoolName%
GOTO :acls

:no-w2k8
SET AccessUserName=NETWORK SERVICE
goto :acls

:acls
REM Following lines set all child folder permissions:
icacls %1\app_browsers /grant "%AccessUserName%":(OI)(CI)RX
icacls %1\app_code /grant "%AccessUserName%":(OI)(CI)RX
icacls %1\app_data /grant "%AccessUserName%":(OI)(CI)M
icacls %1\app_plugins /grant "%AccessUserName%":(OI)(CI)M
icacls %1\bin /grant "%AccessUserName%":(OI)(CI)R
icacls %1\config /grant "%AccessUserName%":(OI)(CI)M
icacls %1\data /grant "%AccessUserName%":(OI)(CI)M
icacls %1\fonts /grant "%AccessUserName%":(OI)(CI)RX
icacls %1\images /grant "%AccessUserName%":(OI)(CI)M
icacls %1\masterpages /grant "%AccessUserName%":(OI)(CI)M
icacls %1\media /grant "%AccessUserName%":(OI)(CI)M
icacls %1\umbraco /grant "%AccessUserName%":(OI)(CI)M
icacls %1\usercontrols /grant "%AccessUserName%":(OI)(CI)R
icacls %1\xslt /grant "%AccessUserName%":(OI)(CI)M
icacls %1\web.config /grant "%AccessUserName%":(OI)(CI)M
icacls %1\web.config /grant "%AccessUserName%":M

REM :mvc
REM If you are using MVC in Umbraco 4.x.y then you need the following action:
SET /P MODEL=Are you using MVC in Umbraco 4.x.y or greater? (Y/N)?
if /i {%MODEL%}=={y} (goto :yes-model)
if /i {%MODEL%}=={yes} (goto :yes-model)
goto :no-model

:yes-model
icacls %1\macroscripts /grant "%AccessUserName%":(OI)(CI)M
icacls %1\views /grant "%AccessUserName%":(OI)(CI)M
goto :styling

:no-model
icacls %1\python /grant "%AccessUserName%":(OI)(CI)M
goto :styling

:styling
REM If you have renamed your stylesheet directory you need the following action:
SET /P STYLES=Have you changed your stylesheet directory location? (Y/N)?
if /i {%STYLES%}=={y} (goto :yes-styles)
if /i {%STYLES%}=={yes} (goto :yes-styles)
goto :no-styles

:yes-styles
SET /P DIR=Please enter the name for your stylesheet directory:
icacls %1\%DIR% /grant "%AccessUserName%":(OI)(CI)M
goto :scripting

:no-styles
icacls %1\css /grant "%AccessUserName%":(OI)(CI)M
goto :scripting

:scripting
REM If you have renamed your javascript directory you need the following action:
SET /P SCRIPTS=Have you changed your javascript directory location? (Y/N)?
if /i {%SCRIPTS%}=={y} (goto :yes-scripts)
if /i {%SCRIPTS%}=={yes} (goto :yes-scripts)
goto :no-scripts

:yes-scripts
SET /P DIR=Please enter the name for your scripts directory:
icacls %1\%DIR% /grant "%AccessUserName%":(OI)(CI)M
goto :robots

:no-scripts
icacls %1\scripts /grant "%AccessUserName%":(OI)(CI)M
goto :robots

:robots
REM If you have installed the Robots.txt editor package you need the following line too
SET /P ANSWER=Do you have the Robots.txt editor package installed? (Y/N)?
if /i {%ANSWER%}=={y} (goto :yes-robots)
if /i {%ANSWER%}=={yes} (goto :yes-robots)
goto :no-robots

:yes-robots
icacls %1\robots.txt /grant "%AccessUserName%":M
goto :end

:no-robots
goto :end

:end
PAUSE


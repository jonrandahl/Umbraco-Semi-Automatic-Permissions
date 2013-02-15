@ECHO off

ECHO Current Directory is %cd%
ECHO Current batch run is %0
ECHO Subject is %1

pause 
  
::--------------------------------------
:: SetUmbracoPermissions
@ECHO.
SET /P W2K8=Are you hosting Umbraco on Windows Server 2008 or newer? (Y/N)?
@ECHO.
IF /i {%W2K8%}=={y} (GOTO :yes-w2k8)
IF /i {%W2K8%}=={yes} (GOTO :yes-w2k8)
GOTO :no-w2k8

:yes-w2k8
@ECHO.
SET /P UserAppPoolName= Please enter the Application Pool Name you would like to grant permission?
@ECHO.
SET AccessUserName=IIS APPPOOL\%UserAppPoolName%
GOTO :acls

:no-w2k8
SET AccessUserName=NETWORK SERVICE
GOTO :acls

:acls
REM Thanks to Arjan for the breakdown idea:
@ECHO.
@ECHO Setting READ permissions...
@ECHO.

icacls %1\ /grant:r "%accessUserName%":(OI)(CI)R
icacls %1\bin /grant:r "%accessUserName%":(OI)(CI)R
icacls %1\config /grant:r "%accessUserName%":(OI)(CI)R
icacls %1\umbraco /grant:r "%accessUserName%":(OI)(CI)R
icacls %1\umbraco_client /grant:r "%accessUserName%":(OI)(CI)R
icacls %1\usercontrols /grant:r "%accessUserName%":(OI)(CI)R
icacls %1\web.config /grant:r "%accessUserName%":R

@ECHO.
@ECHO Setting READ, EXECUTE permissions...
@ECHO.

icacls %1\app_browsers /grant:r "%accessUserName%":(OI)(CI)RX
icacls %1\app_code /grant:r "%accessUserName%":(OI)(CI)RX
icacls %1\fonts /grant:r "%accessUserName%":(OI)(CI)RX

@ECHO.
@ECHO Setting MODIFY permissions...
@ECHO.

icacls %1\app_data /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\app_plugins /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\images /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\masterpages /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\media /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\xslt /grant:r "%accessUserName%":(OI)(CI)M


@ECHO.
@ECHO Checking specific install parameters...
@ECHO.
GOTO :dbchk

:dbchk
REM If you are using SQLCE and NOT SQLServer you need the following:
@ECHO.
SET /P SQLCE=Are you using SQLCE for your datastore? (Y/N)?
@ECHO.
IF /i {%SQLCE%}=={n} (GOTO :no-sqlce)
IF /i {%SQLCE%}=={no} (GOTO :no-sqlce)
GOTO :yes-sqlce

:yes-sqlce
@ECHO.
@ECHO Checkpoint: No Datastore directory permissions needed ...
@ECHO.
REM No data folder needed
GOTO :mvc

:no-sqlce
@ECHO.
@ECHO Checkpoint: Adding Datastore directory permissions ...
@ECHO.
icacls %1\data /grant:r "%accessUserName%":(OI)(CI)M
GOTO :mvc

:mvc
REM If you are using MVC in Umbraco 4.x.y then you need the following action:
@ECHO.
SET /P MODEL=Are you using MVC in Umbraco 4.x.y or greater? (Y/N)?
@ECHO.
IF /i {%MODEL%}=={y} (GOTO :yes-model)
IF /i {%MODEL%}=={yes} (GOTO :yes-model)
GOTO :no-model

:yes-model
@ECHO.
@ECHO Checkpoint: Adding MVC directory permissions ...
@ECHO.
icacls %1\macroscripts /grant "%AccessUserName%":(OI)(CI)M
icacls %1\views /grant "%AccessUserName%":(OI)(CI)M
GOTO :styling

:no-model
@ECHO Checkpoint: Adding WebForms directory permissions ...
@ECHO.
icacls %1\python /grant "%AccessUserName%":(OI)(CI)M
GOTO :styling

:styling
REM If you have renamed your stylesheet directory you need the following action:
@ECHO.
SET /P STYLES=Have you changed your stylesheet directory location? (Y/N)?
@ECHO.
IF /i {%STYLES%}=={y} (GOTO :yes-styles)
IF /i {%STYLES%}=={yes} (GOTO :yes-styles)
GOTO :no-styles

:yes-styles
@ECHO.
SET /P DIR=Please enter the name for your stylesheet directory:
@ECHO.
@ECHO Checkpoint: Adding new stylesheet directory permissions ...
@ECHO.
icacls %1\%DIR% /grant "%AccessUserName%":(OI)(CI)M
GOTO :scripting

:no-styles
@ECHO Checkpoint: Adding stylesheet directory permissions ...
@ECHO.
icacls %1\css /grant "%AccessUserName%":(OI)(CI)M
GOTO :scripting

:scripting
REM If you have renamed your javascript directory you need the following action:
@ECHO.
SET /P SCRIPTS=Have you changed your javascript directory location? (Y/N)?
@ECHO.
IF /i {%SCRIPTS%}=={y} (GOTO :yes-scripts)
IF /i {%SCRIPTS%}=={yes} (GOTO :yes-scripts)
GOTO :no-scripts

:yes-scripts
SET /P DIR=Please enter the name for your scripts directory:
@ECHO.
@ECHO Checkpoint: Adding new javascript directory permissions ...
@ECHO.
icacls %1\%DIR% /grant "%AccessUserName%":(OI)(CI)M
GOTO :robots

:no-scripts
@ECHO Checkpoint: Adding javascript directory permissions ...
@ECHO.
icacls %1\scripts /grant "%AccessUserName%":(OI)(CI)M
GOTO :robots

:robots
REM If you have installed the Robots.txt editor package you need the following line too
@ECHO.
SET /P ANSWER=Do you have the Robots.txt editor package installed? (Y/N)?
@ECHO.
IF /i {%ANSWER%}=={y} (GOTO :yes-robots)
IF /i {%ANSWER%}=={yes} (GOTO :yes-robots)
GOTO :no-robots

:yes-robots
@ECHO Checkpoint: Adding robots.txt permissions ...
@ECHO.
icacls %1\robots.txt /grant "%AccessUserName%":M
GOTO :end

:no-robots
GOTO :end

:end
PAUSE


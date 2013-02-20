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
SET /P userAppPoolName= Please enter the Application Pool Name you would like to enable MODIFY permissions for?
@ECHO.
SET accessUserName=IIS APPPOOL\%userAppPoolName%
GOTO :acls

:no-w2k8
SET accessUserName=NETWORK SERVICE
GOTO :acls

:acls
REM Thanks to Arjan for the breakdown idea:
@echo.
@echo Enabling MODIFY permissions...
@echo.

icacls %1\bin /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\config /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\umbraco /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\umbraco_client /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\usercontrols /grant:r "%accessUserName%":(OI)(CI)M
icacls %1\web.config /grant:r "%accessUserName%":M

pause

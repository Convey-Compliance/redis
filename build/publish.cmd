setlocal

set config=Release
if "%1" == "Debug" (
  set config=Debug
)

set platform_=Win32
if "%2" == "x64" (
  set platform_=x64
)

set copy_files=hiredis.lib Win32_Interop.lib
set copy_opts=/ZB /X /TEE /njh /njs /ndl /nfl /nc /ns /np

set target_dir=\\conveydev.com\files\dev\sdlc-ci\development\user\hiredis\%platform_%\%config%\lib

robocopy ..\bin\%platform_%\%config%\ %target_dir% %copy_files% %copy_opts%
IF ERRORLEVEL 1 exit /B 1

exit /b 0

GOTO :EOF
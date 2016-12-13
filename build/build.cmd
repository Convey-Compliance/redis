@ECHO on

setlocal

set config=Release
if "%1" == "Debug" (
  set config=Debug
)

set platform_=Win32
if "%2" == "x64" (
  set platform_=x64
)

call build_internal %config% %platform_%

if ERRORLEVEL 1 goto :fail
EXIT /B 0

:end
endlocal
exit /b 0

:fail
endlocal

@echo on
setlocal

set config=Release
if "%1" == "Debug" (
  set config=Debug
)

set platform_=Win32
if "%2" == "x64" (
  set platform_=x64
)

call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\vcvars32.bat"

echo ### build hiredis(%config%, %platform_%) ###
msbuild ..\msvs\hiredis\hiredis.vcxproj /p:Configuration=%config%;Platform=%platform_%
if errorlevel 1 goto :fail

echo ### build Win32_Interop(%config%, %platform_%) ###
msbuild ..\src\Win32_Interop\Win32_Interop.vcxproj /p:Configuration=%config%;Platform=%platform_%
if errorlevel 1 goto :fail
goto :end

:fail
endlocal
exit /b 1

:end
endlocal
exit /b 0
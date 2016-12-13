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

set build_cmd=buildconsole /cfg="%config%|%platform_%" /rebuild /usemsbuild
where /q buildconsole
if %errorlevel% == 1 (
  call :revert_to_msbuild
) else (
  echo building using incredibuild(faster)
)

call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\vcvars32.bat"

msbuild ..\msvs\hiredis\hiredis.vcxproj /p:Configuration=%config%;Platform=%platform_%;
if errorlevel 1 goto :fail

msbuild ...\src\Win32_Interop\Win32_Interop.vcxproj /p:Configuration=%config%;Platform=%platform_%
if errorlevel 1 goto :fail

copy ..\msvs\hiredis\%platform_%\%config%\hiredis.lib hiredis.lib

copy ..\src\Win32_Interop\%platform_%\%config%\Win32_Interop.lib Win32_Interop.lib

:revert_to_msbuild
echo incredibuild is not found - building using msbuild(slower)
set build_cmd=msbuild /p:Configuration=%config%;Platform=%platform_%
goto :eof

:fail
endlocal
exit /b 1

:end
endlocal
exit /b 0
::Listar los procesos de archivos ejecutables actualmente en memoria
@echo off

echo Listando procesos ejecutables en memoria:
echo.

for /f "tokens=1 delims= " %%a in ('tasklist /nh /fi "STATUS eq RUNNING" /fi "imagename ne svchost.exe" ^| findstr /i ".exe"') do (
  echo %%a
)

echo.
pause
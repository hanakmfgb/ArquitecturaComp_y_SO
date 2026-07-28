@echo off
echo.
echo   Informacion del Sistema
echo  ------------------------
echo.
systeminfo | findstr /C:"Nombre del sistema"
systeminfo | findstr /C:"Nombre del SO"
wmic csproduct get name, vendor, identifyingnumber /format:table
pause
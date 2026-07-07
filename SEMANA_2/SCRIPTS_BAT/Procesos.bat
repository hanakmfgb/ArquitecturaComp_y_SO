@echo off

echo Listando procesos en ejecucion...

tasklist /nh /fo csv | findstr /i ".exe" > c:\temp\procesos.txt

echo Listado de procesos guardado en "c:\temp\procesos.txt"
pause
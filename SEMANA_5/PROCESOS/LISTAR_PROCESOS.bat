@echo off

echo Listando procesos en ejecucion...

tasklist /nh /fo csv | findstr /i ".exe" > procesos.txt

echo Listado de procesos guardado en "procesos.txt"

pause 
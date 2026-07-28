@echo off

echo.
echo           Informacion del sistema
echo =====================================================

echo.
echo Procesador:
wmic cpu get name, maxclockspeed, numberofcores
echo.

echo Memoria RAM:
wmic memorychip get capacity, speed
echo.

echo Disco duro:
wmic logicaldisk get caption, size, freespace
echo.

echo Tarjeta grafica:
wmic path win32_VideoController get name
echo.

echo Placa base:
wmic baseboard get product, manufacturer, version
echo.

echo.
pause

@ECHO off

SET "GRUPO1=192.168.174.2 192.168.100.9"
SET "GRUPO2=192.168.174.128"

SET LISTAWS=%GRUPO1%;%GRUPO2%

ECHO --------------------------------------------
ECHO CONEXIONES ACTIVAS
ECHO --------------------------------------------
ECHO Usuario   WORKSTATION TIME %date% %time%
ECHO --------------------------------------------
FOR %%A IN (%LISTAWS%) DO (
    FOR /f "tokens=2" %%i IN ('qwinsta /SERVER:%%A ^| find /i "Active"') DO ECHO %%i -- %%A
)
ECHO --------------------------------------------
PAUSE
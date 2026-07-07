:: Script para validar conexiones
@ECHO off
:: Lista de direcicones IP o sitios web
SET "GRUPO1=google.com amazon.com mercadolibre.com "
SET "GRUPO2=oracle.com nvidia.com microsoft.com"

:: Concatenar dos listas
SET LISTAWS=%GRUPO1%;%GRUPO2%

::Imprimir resultados
ECHO -----------------------------------------------
ECHO Conexiones activas ****
ECHO -----------------------------------------------
ECHO Prueba de CONEXION  FECHA y HORA %date% %time%

FOR %%A IN (%LISTAWS%) DO (
    ping %%A
)

ECHO ------------------------------------------------
PAUSE
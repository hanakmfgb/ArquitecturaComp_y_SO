@echo off
@echo Prueba de PING
::Esto es un comentario
SET "GRUPO1=google.com amazon.com"
SET "GRUPO2=ibm.com dell.com"

SET LISTAS=%GRUPO1%;%GRUPO1%

ECHO ---------------------------------------
ECHO TEST DE CONEXIONES 
ECHO ---------------------------------------
ECHO Prueba de conexión TIME %date% %time%
ECHO ---------------------------------------

FOR %%A IN (%LISTAS%) DO (
      ping %%A
)
ECHO ---------------------------------------
PAUSE 
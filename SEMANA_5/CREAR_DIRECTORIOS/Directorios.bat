@echo off

REM ========================================================================
REM [a] indice de bucle for para recorrer directorios
REM [FOLDER] variable guarda el nombre de la carpeta
REM ========================================================================

REM ========================================================================
REM Concatenar partes de la fecha para el nombre de directorio 
REM ========================================================================

SET aa=%date:~6,4%
SET mm=%date:~3,2%
SET dd=%date:~0,2%
SET FOLDER=%mm%-%dd%-%aa%

REM ========================================================================
REM Creación de directorio
REM ========================================================================

FOR /L %%a in (1,1,10) DO (

 IF %%a LSS 10 (
    MKDIR "C:\Temp\RE0"%%a"\A1\"%FOLDER% 
	MKDIR "C:\Temp\RE0"%%a"\A2\"%FOLDER%
	MKDIR "C:\Temp\RE0"%%a"\A3\"%FOLDER% 
	MKDIR "C:\Temp\RE0"%%a"\A4\"%FOLDER% 
	MKDIR "C:\Temp\RE0"%%a"\A5\"%FOLDER% 
  ) ELSE (
    MKDIR "C:\Temp\RE0"%%a"\B1\"%FOLDER% 
	MKDIR "C:\Temp\RE0"%%a"\B2\"%FOLDER% 
	MKDIR "C:\Temp\RE0"%%a"\B3\"%FOLDER% 
	MKDIR "C:\Temp\RE0"%%a"\B4\"%FOLDER% 
	MKDIR "C:\Temp\RE0"%%a"\B5\"%FOLDER%
	)
	
)
@echo off
title Sincronizador de Carpetas - Cátedra de Sistemas Operativos
color 0A
chcp 65001 > nul

:: =========================================================================
:: CONFIGURACIÓN INICIAL (Ruta origen por defecto)
:: =========================================================================
:: Puedes modificar esta ruta por la que uses habitualmente
set "ORIGEN=C:\MisDocumentos\Clases"

:MENU
cls
echo =========================================================================
echo                SINCRONIZADOR PROFESIONAL DE CARPETAS (ROBOCOPY)
echo =========================================================================
echo  [!] Carpeta Origen actual: "%ORIGEN%"
echo =========================================================================
echo.
echo Seleccione el destino de la sincronización:
echo  [1] Sincronizar con Dispositivo USB / Disco Externo (Ej: F:, G:)
echo  [2] Sincronizar con SharePoint (Ruta Local Sincronizada)
echo  [3] Cambiar la Carpeta de Origen
echo  [4] Salir
echo.
echo =========================================================================
set /p "opcion=Elija una opción (1-4): "

if "%opcion%"=="1" goto SYNC_USB
if "%opcion%"=="2" goto SYNC_SHAREPOINT
if "%opcion%"=="3" goto CHANGE_ORIGIN
if "%opcion%"=="4" goto EXIT
goto MENU

:CHANGE_ORIGIN
cls
echo =========================================================================
echo                     CAMBIAR CARPETA ORIGEN
echo =========================================================================
echo Origen actual: "%ORIGEN%"
echo.
set /p "new_origen=Arrastre la nueva carpeta aquí o escriba la ruta completa: "
:: Limpiar comillas por si el usuario arrastró la carpeta al terminal
set "new_origen=%new_origen:"=%"
if exist "%new_origen%" (
    set "ORIGEN=%new_origen%"
    echo.
    echo [OK] Carpeta de origen actualizada con éxito.
) else (
    echo.
    echo [ERROR] La ruta especificada no existe.
)
pause
goto MENU

:SYNC_USB
cls
echo =========================================================================
echo                 OPCIÓN 1: SINCRONIZAR CON DISPOSITIVO USB
echo =========================================================================
echo.
set /p "letra=Introduzca solo la letra de la unidad USB (Ejemplo: F o G): "
:: Limpiar posibles caracteres extraños
set "letra=%letra::=%"
set "letra=%letra: =%"

set "DESTINO=%letra%:\Sincronizacion_Respaldos"

if not exist "%letra%:\" (
    echo.
    echo [ERROR] La unidad %letra%: no está conectada o no es válida.
    pause
    goto MENU
)
goto EJECUTAR_SYNC

:SYNC_SHAREPOINT
cls
echo =========================================================================
echo                 OPCIÓN 2: SINCRONIZAR CON SHAREPOINT
echo =========================================================================
echo.
echo NOTA DE ARQUITECTURA DE OS:
echo Sincronizar directamente a una URL web (https://...) mediante comandos
echo es inestable debido a las capas de autenticación moderna de Microsoft.
echo La "buena práctica" es usar la ruta local del cliente de SharePoint/OneDrive 
echo (Ej: C:\Users\Nombre\Organización\Sitio - Documentos) para que el agente
echo de fondo del S.O. se encargue de la subida a la nube de manera asíncrona.
echo.
set /p "sp_path=Pegue la ruta local de su carpeta sincronizada de SharePoint: "
set "sp_path=%sp_path:"=%"

set "DESTINO=%sp_path%"

if not exist "%DESTINO%" (
    echo.
    echo [ERROR] La ruta local de SharePoint no existe o no está sincronizada.
    pause
    goto MENU
)
goto EJECUTAR_SYNC

:EJECUTAR_SYNC
cls
echo =========================================================================
echo                     CONFIRMACIÓN DE ACCIÓN (ESPEJO)
echo =========================================================================
echo  ORIGEN:  "%ORIGEN%"
echo  DESTINO: "%DESTINO%"
echo =========================================================================
echo [!] ADVERTENCIA DE SEGURIDAD: 
echo Se utilizará el parámetro /MIR (Mirror/Espejo). Esto significa que:
echo  1. Todo archivo nuevo o modificado en Origen se copiará al Destino.
echo  2. ¡CUIDADO! Cualquier archivo que exista en el Destino pero NO en 
echo     el Origen será ELIMINADO del Destino para mantener la paridad exacta.
echo =========================================================================
set /p "confirmar=¿Está seguro de proceder con la sincronización? (S/N): "
if /i not "%confirmar%"=="S" goto MENU

echo.
echo [PROCESANDO] Iniciando sincronización robusta...
echo.

:: EXPLICACIÓN DE PARÁMETROS PARA LA CLASE:
:: /MIR  -> Modo Espejo (Sincroniza directorios y subdirectorios, borra del destino lo que no esté en origen).
:: /R:3  -> Reintenta la copia de un archivo bloqueado máximo 3 veces (evita bucles infinitos).
:: /W:5  -> Tiempo de espera de 5 segundos entre reintentos.
:: /MT:8 -> Multithreading. Utiliza 8 hilos en paralelo de la CPU para acelerar la copia de archivos pequeños.
:: /FFT  -> Crucial para USB: Asume la granularidad de hora del formato FAT (evita falsos positivos de modificación).
:: /XO   -> Excluye archivos más antiguos en origen (si el archivo en destino es más nuevo, no lo sobrescribe).
:: /NP   -> No muestra el porcentaje de progreso por archivo (limpia la salida de consola).

robocopy "%ORIGEN%" "%DESTINO%" /MIR /R:3 /W:5 /MT:8 /FFT /XO /NP

echo.
echo =========================================================================
echo  [OK] Proceso completado. Código de retorno de la CPU (ErrorLevel): %ERRORLEVEL%
echo =========================================================================
echo  * Nota: Un ErrorLevel entre 0 y 3 indica éxito o copia sin errores graves.
echo =========================================================================
pause
goto MENU

:EXIT
echo.
echo Saliendo del sincronizador... ¡Hasta la próxima clase!
pause
exit
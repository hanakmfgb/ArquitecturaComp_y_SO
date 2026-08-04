# =========================================================================
# SCRIPT DE AUDITORÍA: Inicios de sesión de los últimos 7 días
# Asignatura: Arquitectura de Computadores y Sistemas Operativos
# =========================================================================

# 1. Definir el rango de búsqueda (7 días hacia atrás)
$diasAtras = 7
$fechaInicio = (Get-Date).AddDays(-$diasAtras)

# 2. Definir los ID de evento clave del Log de Seguridad
# ID 4624 = Inicio de sesión exitoso (Successful Logon)
# ID 4625 = Intento de inicio de sesión fallido (Failed Logon)
$eventIDs = @(4624, 4625)

Write-Host "Buscando eventos en el registro de Seguridad desde: $fechaInicio..." -ForegroundColor Cyan

try {
    # 3. Consultar eficientemente usando un FilterHashtable (procesado a nivel de OS)
    $eventosRaw = Get-WinEvent -FilterHashtable @{
        LogName   = 'Security'
        Id        = $eventIDs
        StartTime = $fechaInicio
    } -ErrorAction Stop

    # 4. Procesar y estructurar la información en objetos legibles
    $reporteLogons = foreach ($evento in $eventosRaw) {
        
        # Parseamos el evento a formato XML para extraer propiedades sin importar variaciones de estructura
        $xml = [xml]$evento.ToXml()
        $eventData = $xml.Event.EventData.Data
        
        # Extraemos las propiedades clave de la estructura XML del evento
        $usuario = ($eventData | Where-Object { $_.Name -eq 'TargetUserName' }).InnerText
        $tipoLogonNum = ($eventData | Where-Object { $_.Name -eq 'LogonType' }).InnerText
        $ipOrigen = ($eventData | Where-Object { $_.Name -eq 'IpAddress' }).InnerText
        
        # Filtramos cuentas de sistema ruidosas (SYSTEM, LOCAL SERVICE, etc.) para ver solo usuarios reales
        if ($usuario -and ($usuario -notmatch "SYSTEM|SERVICE|ANONYMOUS|DWM-|UMFD-")) {
            
            # Traducimos el Logon Type (Tipo de Inicio de Sesión) a texto comprensible
            $tipoLogonTexto = switch ($tipoLogonNum) {
                2  { "Local (Teclado y Monitor)" }
                3  { "Red (Ej: Carpeta compartida o recurso)" }
                4  { "Servicio por lotes (Batch/Tarea programada)" }
                5  { "Servicio del Sistema" }
                7  { "Desbloqueo de pantalla (Lock/Unlock)" }
                10 { "Escritorio Remoto (RDP)" }
                11 { "Caché (Credenciales guardadas sin red)" }
                Default { "Otro ($tipoLogonNum)" }
            }

            # Creamos un objeto ordenado por cada evento procesado
            [PSCustomObject]@{
                Fecha            = $evento.TimeCreated
                ID_Evento        = $evento.Id
                Resultado        = if ($evento.Id -eq 4624) { "Éxito" } else { "Fallo" }
                Usuario          = $usuario
                Tipo_Conexion    = $tipoLogonTexto
                IP_Origen        = if ($ipOrigen -eq "-") { "Local" } else { $ipOrigen }
            }
        }
    }

    # 5. Presentación de resultados
    if ($reporteLogons) {
        Write-Host "`nResultados encontrados:" -ForegroundColor Green
        
        # Opción A: Mostrar en consola formateado como tabla
        $reporteLogons | Format-Table -AutoSize
        
        # Opción B (Opcional): Si deseas abrir una interfaz gráfica interactiva nativa de Windows,
        # descomenta la siguiente línea (borra el símbolo #):
        # $reporteLogons | Out-GridView -Title "Auditoría de Inicios de Sesión - Últimos $diasAtras días"

        # Opción C (Opcional): Si deseas exportarlo a un archivo CSV para reportes:
        # $reporteLogons | Export-Csv -Path "$HOME\Desktop\Inicios_Sesion_Ultimos_7_Dias.csv" -NoTypeInformation -Encoding Utf8
    } else {
        Write-Host "No se registraron inicios de sesión de usuarios reales en este periodo." -ForegroundColor Yellow
    }

} catch [System.Diagnostics.Eventing.Reader.EventLogNotFoundException] {
    Write-Host "[ERROR] El log de seguridad no está disponible." -ForegroundColor Red
} catch {
    Write-Host "[ERROR] Asegúrate de ejecutar PowerShell como ADMINISTRADOR." -ForegroundColor Red
    Write-Host "Detalle del error: $_" -ForegroundColor Red
}
# Define el archivo que contiene la lista de servidores
$serverListFile = "C:\temp\servers.txt"

# Define el archivo donde se guardarán los resultados
$resultsFile = "C:\temp\server_connectivity_results.txt"

# Crea un objeto de flujo para escribir los resultados
$resultsStream = New-Object System.IO.StreamWriter -ArgumentList $resultsFile

# Escribe un encabezado en el archivo de resultados
$resultsStream.WriteLine("Servidor, Estado, Mensaje de Error")

try {
    # Lee la lista de servidores desde el archivo
    $servers = Get-Content -Path $serverListFile

    # Itera sobre cada servidor en la lista
    foreach ($server in $servers) {
        $server = $server.Trim() #Elimina espacios en blanco al inicio y final de la línea

        # Intenta realizar una comprobación de conexión
        try {
            $testResult = Test-Connection -ComputerName $server -Count 1 -Quiet
            $status = if ($testResult) { "Conectado" } else { "Desconectado" }
            $errorMessage = ""

        }
        catch {
            $status = "Error"
            $errorMessage = $_.Exception.Message
        }
        finally{
            # Escribe los resultados en el archivo
            $resultsStream.WriteLine("{0}, {1}, {2}", $server, $status, $errorMessage)
        }
    }

    Write-Host "Resultados guardados en: $resultsFile"

}
catch {
    Write-Error "Error al procesar el archivo: $_"
}
finally {
    # Cierra el flujo de escritura
    $resultsStream.Close()
}


Write-Host "Script finalizado."
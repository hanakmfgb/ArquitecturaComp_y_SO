# =========================================================================
# 1. MANIPULACIÓN DE ARCHIVO DE TEXTO PLANO (.txt)
# =========================================================================

# Definir la ruta del archivo 
$rutaTxt = "C:\TEMP\clase_sistemas_operativos.txt"

Write-Host "--- TRABAJANDO CON ARCHIVO DE TEXTO ---" -ForegroundColor Cyan

# A. CREACIÓN Y ESCRITURA INICIAL (Sobrescribe si ya existe)
$contenidoInicial = "Tema 1: Arquitectura de Computadores e Hilos.`nTema 2: Gestión de Memoria en Linux.`nTema 3: Sistemas de Archivos NTFS."
Set-Content -Path $rutaTxt -Value $contenidoInicial
Write-Host "[OK] Archivo creado en: $rutaTxt" -ForegroundColor Green

# B. ACCESO (Lectura)
Write-Host "`nContenido actual del archivo:" -ForegroundColor Yellow
Get-Content -Path $rutaTxt

# C. MODIFICACIÓN (Reemplazar una palabra específica en el archivo)
# Leemos el archivo en memoria, reemplazamos 'Linux' por 'Sistemas Unix' y guardamos de vuelta
(Get-Content -Path $rutaTxt) -replace "Linux", "Sistemas Unix" | Set-Content -Path $rutaTxt
Write-Host "`n[OK] Archivo modificado. Nuevo contenido:" -ForegroundColor Green
Get-Content -Path $rutaTxt
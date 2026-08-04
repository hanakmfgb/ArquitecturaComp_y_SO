# =========================================================================
# 2. MANIPULACIÓN DE ARCHIVOS CSV (Objetos estructurados)
# =========================================================================

$rutaCsv = "C:\TEMP\notas_alumnos.csv"

Write-Host "--- TRABAJANDO CON ARCHIVO CSV ---" -ForegroundColor Cyan

# A. CREACIÓN Y EXPORTACIÓN (Creamos objetos PSCustomObject en memoria)
$alumnos = @(
    [PSCustomObject]@{ ID = 101; Nombre = "Ana Gomez"; Nota = 9.5; Estado = "Aprobado" }
    [PSCustomObject]@{ ID = 102; Nombre = "Carlos Perez"; Nota = 4.8; Estado = "Reprobado" }
    [PSCustomObject]@{ ID = 103; Nombre = "Lucia Diaz"; Nota = 8.0; Estado = "Aprobado" }
)
# El parámetro -NoTypeInformation evita que se guarde la cabecera de metadatos de .NET
$alumnos | Export-Csv -Path $rutaCsv -NoTypeInformation -Encoding Utf8
Write-Host "[OK] CSV exportado con éxito." -ForegroundColor Green

# B. ACCESO (Importación y lectura como objetos reales)
Write-Host "`nLeyendo datos del CSV (reconstruidos como objetos):" -ForegroundColor Yellow
$datosImportados = Import-Csv -Path $rutaCsv
$datosImportados | Format-Table -AutoSize

# C. MODIFICACIÓN (Actualizar la nota de Carlos Perez de 4.8 a 10.0 y recalcular su estado)
Write-Host "`nModificando registro de Carlos Perez..." -ForegroundColor Yellow
foreach ($alumno in $datosImportados) {
    if ($alumno.Nombre -eq "Carlos Perez") {
        $alumno.Nota = "10.0"  # Modificación de propiedad
        $alumno.Estado = "Aprobado"
    }
}
# Guardamos los cambios de vuelta al disco duro
$datosImportados | Export-Csv -Path $rutaCsv -NoTypeInformation -Encoding Utf8
Write-Host "[OK] CSV actualizado. Datos finales:" -ForegroundColor Green
Import-Csv -Path $rutaCsv | Format-Table -AutoSize
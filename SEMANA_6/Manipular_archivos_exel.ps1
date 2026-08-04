# =========================================================================
# 3. MANIPULACIÓN DE EXCEL (.xlsx) USANDO COM (Inter-Process Communication)
# =========================================================================

$rutaExcel = "C:\TEMP\reporte_arquitectura.xlsx"

Write-Host "--- TRABAJANDO CON EXCEL (.XLSX) ---" -ForegroundColor Cyan

try {
    # A. CREACIÓN Y APERTURA DE LA INSTANCIA DE EXCEL
    # Creamos un proceso invisible de Excel en segundo plano gerenciado por el S.O.
    $excel = New-Object -ComObject Excel.Application
    $excel.Visible = $false
    $excel.DisplayAlerts = $false

    # Creamos un nuevo libro y seleccionamos la primera hoja
    $workbook = $excel.Workbooks.Add()
    $worksheet = $workbook.Worksheets.Item(1)

    # B. ESCRITURA DE DATOS (Fila, Columna)
    $worksheet.Cells.Item(1, 1) = "Componente"
    $worksheet.Cells.Item(1, 2) = "Estado Físico"
    $worksheet.Cells.Item(2, 1) = "Memoria Caché L1"
    $worksheet.Cells.Item(2, 2) = "Operativo"

    # Guardamos el archivo y cerramos el libro
    $workbook.SaveAs($rutaExcel)
    $workbook.Close()
    Write-Host "[OK] Libro de Excel creado con éxito." -ForegroundColor Green

    # C. ACCESO Y MODIFICACIÓN
    Write-Host "`nAbriendo y modificando celda en Excel..." -ForegroundColor Yellow
    $workbook = $excel.Workbooks.Open($rutaExcel)
    $worksheet = $workbook.Worksheets.Item(1)

    # Modificamos el valor de la celda (2,2) de "Operativo" a "Mantenimiento preventivo"
    $worksheet.Cells.Item(2, 2) = "Mantenimiento preventivo1"

    # Guardamos y cerramos de forma segura
    $workbook.Save()
    $workbook.Close()
    Write-Host "[OK] Celda modificada con éxito en el Excel." -ForegroundColor Green

} catch {
    Write-Host "[ERROR] Ocurrió un fallo. Asegúrate de tener MS Excel instalado." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
} finally {
    # D. LIBERACIÓN DE RECURSOS DEL SISTEMA OPERATIVO (Crucial en Gestión de Memoria)
    # Cerramos el proceso de fondo de Excel y forzamos al Garbage Collector a limpiar la RAM
    if ($excel) {
        $excel.Quit()
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($worksheet) | Out-Null
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($workbook) | Out-Null
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($excel) | Out-Null
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        Write-Host "Proceso de Excel cerrado y memoria liberada en el S.O." -ForegroundColor DarkGray
    }
}
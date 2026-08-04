#Inicializo la variable
$x=0
#Declaro funciones
function preguntar($componente){
  Clear-Host
  Write-Host "¿Que quieres ver?"
  Write-Host "1. Nombre"
  Write-Host "2. Fabricante"
  Write-Host "3. Detallada"
  #Esta línea toma la opción del usuario ingresada por la consola
  $opcion=Read-Host "Elige una opción"
  if ($opcion -eq 1)
  {
    Get-WmiObject -Class $componente|ft Name
  }
  if ($opcion -eq 2)
  {
    Get-WmiObject -Class $componente|ft Manufacturer
  }
  if ($opcion -eq 3)
  {
    Get-WmiObject -Class $componente|fl *
  }
}  

#Inicio de menu
while ($x -ne 6)
{
  Clear-Host
  Write-Host "Información de Hw y Sw"
  Write-Host ""
  Write-Host "1. Procesador"
  Write-Host "2. Placa Base"
  Write-Host "3. BIOS"
  Write-Host "4. Memoria (RAM)"
  Write-Host "5. Discos de Almacenamiento"
  Write-Host "6. Salir"
  $x=Read-Host "Seleccione opción"
  if ($x -eq 1){preguntar("win32_processor")}
  if ($x -eq 2){preguntar("win32_baseboard")}
  if ($x -eq 3){preguntar("win32_Bios")}
  if ($x -eq 4){preguntar("win32_physicalmemory")} # Nueva clase WMI para RAM
  if ($x -eq 5){preguntar("win32_diskdrive")}      # Nueva clase WMI para Discos
  if ($x -ne 6)
  {
    Read-Host "Pulsa para continuar"
  }
}
Param(
  [string]$Path = 'c:/carpeta_origen',
  [string]$DestinationPath = 'c:/carpeta_Destino/'
)
If (-Not (Test-Path $Path)) 
{
  Throw "El directorio de origen $Path no existe, por favor especifique un directorio que exista"
}
$date = Get-Date -format "yyyy-MM-dd"
$DestinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"
If (-Not (Test-Path $DestinationFile)) 
{
  Compress-Archive -Path $Path -CompressionLevel 'Fastest' -DestinationPath "$($DestinationPath + 'backup-' + $date)"
  Write-Host "Creando backup en $($DestinationPath + 'backup-' + $date + '.zip')"
} Else {
  Write-Error "El Backup de hoy ya existe"
}

#Borra archivos mas antiguos de 15 dias
Get-ChildItem -Path "C:\Temp\HISTORIAL" -Recurse | Where-Object {$_.LastWriteTime -LT (Get-Date).AddDays(-15)} | Remove-Item -Recurse -Confirm:$false -force
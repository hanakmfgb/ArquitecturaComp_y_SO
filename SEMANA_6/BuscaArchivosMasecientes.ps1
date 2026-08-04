#Busque archivos modificados en los últimos 10 días
$Days = 60
$Time = (Get-Date).Adddays(-($Days))
Get-ChildItem -Path C:\temp -Filter *.txt -Recurse -ErrorAction SilentlyContinue -Force | Where-Object { $_.LastWriteTime -gt $Time }

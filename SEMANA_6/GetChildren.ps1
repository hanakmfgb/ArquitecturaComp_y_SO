#Get-ChildItem C:\Temp 

#Get-ChildItem C:\Temp -Recurse | % {if($_.Name | Select-String "pdf"){$_.FullName}}

#Busque un archivo en un directorio.
#Get-ChildItem -Path C:\Temp -Filter *H*.pdf -Recurse -ErrorAction SilentlyContinue -Force 


#Busque un archivo en todo el disco, pero muestre la ruta de acceso completa.
#Get-ChildItem -Path C:\ -Filter test.txt -Recurse -ErrorAction SilentlyContinue -Force | % { $_.fullname }


#Busque archivos modificados en los últimos 10 días
#$Days = 365
#$Time = (Get-Date).Adddays(-($Days))
#Get-ChildItem -Path C:\temp -Filter *.txt -Recurse -ErrorAction SilentlyContinue -Force | Where-Object { $_.LastWriteTime -gt $Time }

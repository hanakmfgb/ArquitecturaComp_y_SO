[int]$inicial=Read-Host "Dime el numeró inicial de la IP dento de la red 198.168.100.1"
[int]$final=Read-Host "Dime el numeró final de la IP dento de la red 198.168.100.1"
for ($i = $inicial; $i -lt $final+1; $i++)
{ 
    $respuesta=Test-Connection 198.168.100.$i -Count 1 -Quiet
    if ($respuesta)
    {
        Write-Host "198.168.100.$i está Conectado" 
    }else{
        Write-Host "198.168.100.$i NO está Conectado" 
    }
}
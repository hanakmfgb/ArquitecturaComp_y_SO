@echo Prueba de lista en archivo - revisar [pingLOG.txt]...
:: multiIP.bat 
@echo off > pingLOG.txt 

for /f "tokens=*" %%I in (iplist.txt) do call :comprobar %%I 
goto :eof 

:comprobar
echo %DATE% >> pingLOG.txt
echo %TIME% >> pingLOG.txt 
ping %1 >> pingLOG.txt 
:: FIN  
Pause 
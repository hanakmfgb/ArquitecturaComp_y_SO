@echo off
echo Ordenando la carpeta de descargas...

REM Define la ruta de la carpeta de descargas
set "descargas=%USERPROFILE%\Downloads"

REM Crea carpetas para diferentes tipos de archivos
mkdir "%descargas%\Documentos" 2>nul
mkdir "%descargas%\Imagenes" 2>nul
mkdir "%descargas%\Videos" 2>nul
mkdir "%descargas%\Musica" 2>nul
mkdir "%descargas%\Comprimidos" 2>nul
mkdir "%descargas%\Otros" 2>nul

REM Mueve los archivos a sus respectivas carpetas
for %%a in ("%descargas%\*.docx" "%descargas%\*.xlsx" "%descargas%\*.pptx" "%descargas%\*.pdf" "%descargas%\*.txt") do move "%%a" "%descargas%\Documentos"
for %%a in ("%descargas%\*.jpg" "%descargas%\*.jpeg" "%descargas%\*.png" "%descargas%\*.gif" "%descargas%\*.bmp") do move "%%a" "%descargas%\Imagenes"
for %%a in ("%descargas%\*.mp4" "%descargas%\*.avi" "%descargas%\*.mkv" "%descargas%\*.mov" "%descargas%\*.wmv") do move "%%a" "%descargas%\Videos"
for %%a in ("%descargas%\*.mp3" "%descargas%\*.wav" "%descargas%\*.flac" "%descargas%\*.ogg") do move "%%a" "%descargas%\Musica"
for %%a in ("%descargas%\*.zip" "%descargas%\*.rar" "%descargas%\*.7z" "%descargas%\*.tar" "%descargas%\*.gz") do move "%%a" "%descargas%\Comprimidos"
for %%a in ("%descargas%\*.*") do if /I not "%%~xa"==".bat" move "%%a" "%descargas%\Otros"

echo La carpeta de descargas se ha ordenado correctamente.
pause

@echo off
title Downloader de Músicas
chcp 65001 > nul
mode con: cols=80 lines=20

REM Diretório padrão no PC
set pasta_pc=C:\Musicas

REM Detecta pendrive automaticamente (se existir a pasta "Musicas")
set pasta_pendrive=
for %%D in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%D:\Musicas\ (
        set pasta_pendrive=%%D:\Musicas
    )
)

:menu
cls
echo ============================================
echo  BOA SORTE EM SEUS DOWNLOADS :) instagram: marcoskz_ 
echo ============================================
echo  1 - Baixar para o PC
echo  2 - Baixar para o Pendrive
echo  3 - Sair
echo ============================================
set /p opcao="Escolha uma opção: "

if "%opcao%"=="1" set destino=%pasta_pc% & goto tipo_download
if "%opcao%"=="2" if not "%pasta_pendrive%"=="" set destino=%pasta_pendrive% & goto tipo_download
if "%opcao%"=="2" if "%pasta_pendrive%"=="" echo Nenhum pendrive detectado! Salvando no disco rígido do seu computador... & set destino=%pasta_pc% & goto tipo_download
if "%opcao%"=="3" exit
goto menu

:tipo_download
cls
if not exist "%destino%" mkdir "%destino%"
echo Onde salvar: %destino%
echo ============================================
echo  1 - Baixar uma música pelo nome
echo  2 - Baixar várias músicas de um artista
echo  3 - Voltar ao menu principal
echo ============================================
set /p opcao="Escolha uma opção: "

if "%opcao%"=="1" goto baixar_uma
if "%opcao%"=="2" goto baixar_artista
if "%opcao%"=="3" goto menu
goto tipo_download

:baixar_uma
cls
set /p nome_musica="Digite o nome da música: "
C:\yt-dlp\yt-dlp.exe -x --audio-format mp3 --match-filter "duration<600" -o "%destino%\%%(title)s.%%(ext)s" "ytsearch1:%nome_musica%"
echo Música baixada com sucesso!
pause
goto tipo_download

:baixar_artista
cls
set /p artista="Digite o nome do artista: "
set /p qtd="Quantas músicas deseja baixar? (Máx 50) "

if "%qtd%"=="" set qtd=5
if %qtd% GTR 50 set qtd=50

C:\yt-dlp\yt-dlp.exe -x --audio-format mp3 --match-filter "duration<600" -o "%destino%\%%(title)s.%%(ext)s" "ytsearch%qtd%:%artista%"
echo Músicas baixadas com sucesso!
pause
goto tipo_download
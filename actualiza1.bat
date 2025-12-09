@echo off
rem === Variables de Configuracion ===
set REPO_NAME=Atlas
set DEFAULT_COMMIT_MESSAGE=Actualizacion de Atlas
set GIT_BRANCH=master
set PAUSE_DURATION=5

rem === Encabezado ===
echo.
echo ===========================================
echo   Script de Actualizacion para %REPO_NAME%
echo ===========================================
echo.

rem === PASO 1: Confirmacion inicial ===
:CONFIRMATION_LOOP
set /p confirmation="^¿Deseas iniciar la actualizacion de %REPO_NAME% (git add, commit, push)? (s/n): "

rem Manejar la respuesta (comparacion sin distinguir mayusculas/minusculas)
if /i "%confirmation%"=="n" goto CANCEL
if /i "%confirmation%"=="s" goto START_UPDATE

echo Entrada no valida. Por favor, ingresa 's' o 'n'.
goto CONFIRMATION_LOOP

:CANCEL
echo Proceso cancelado por el usuario.
goto END

:START_UPDATE
echo.

rem === PASO 2: Git ADD ===
echo Agregando cambios...
echo El script ejecutara 'git add .' en %PAUSE_DURATION% segundos.
echo Presiona Ctrl+C para cancelar...
timeout /t %PAUSE_DURATION% /nobreak > nul

echo.
echo Ejecutando: git add .
git add .
if errorlevel 1 goto ERROR_ADD
echo 'git add .' completado con exito.
echo.

rem === PASO 3: Git COMMIT ===
echo Haciendo commit...
set "commit_message="
set /p commit_message="Introduce el mensaje del commit (Enter para usar el predeterminado '%DEFAULT_COMMIT_MESSAGE%'): "

rem Asignar mensaje predeterminado si no se introdujo nada
if "%commit_message%"=="" set commit_message=%DEFAULT_COMMIT_MESSAGE%

echo.
echo El script ejecutara 'git commit' en %PAUSE_DURATION% segundos.
echo Presiona Ctrl+C para cancelar...
timeout /t %PAUSE_DURATION% /nobreak > nul

echo.
echo Ejecutando: git commit -m "%commit_message%"
git commit -m "%commit_message%"
if errorlevel 1 goto ERROR_COMMIT
echo 'git commit' completado con exito.
echo.

rem === PASO 4: Git PUSH ===
echo Enviando cambios al repositorio remoto...
echo El script ejecutara 'git push' en %PAUSE_DURATION% segundos.
echo Presiona Ctrl+C para cancelar...
timeout /t %PAUSE_DURATION% /nobreak > nul

echo.
echo Ejecutando: git push origin %GIT_BRANCH%
git push origin %GIT_BRANCH%
if errorlevel 1 goto ERROR_PUSH
echo 'git push' completado con exito.
echo.

rem === Finalizacion Exitosa ===
echo ===========================================
echo   PROCESO DE ACTUALIZACION DE %REPO_NAME% FINALIZADO.
echo ===========================================
goto END

rem === Manejo de Errores ===
:ERROR_ADD
echo ERROR: Fallo al agregar archivos (git add .).
goto END

:ERROR_COMMIT
echo ERROR: Fallo al ejecutar el commit (git commit -m "%commit_message%").
goto END

:ERROR_PUSH
echo ERROR: Fallo al enviar los cambios (git push).
goto END

:END
echo.
pause
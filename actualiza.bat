# Script de Actualización para Atlas en el terminal de VS Code (PowerShell)

$REPO_NAME = "Atlas"
$DEFAULT_COMMIT_MESSAGE = "Actualizacion de Atlas"
$GIT_BRANCH = "main"
$PAUSE_DURATION = 5

Write-Host "`n==========================================="
Write-Host "     Script de Actualizacion para $REPO_NAME"
Write-Host "===========================================`n"

# === PASO 1: Confirmación inicial ===
$confirmation = Read-Host "¿Deseas iniciar la actualizacion de $REPO_NAME (git add, commit, push)? (s/n)"
if ($confirmation -ne "s") {
    Write-Host "Proceso cancelado por el usuario."
    exit
}
Write-Host "`n"

# === PASO 2: Git ADD ===
Write-Host " Agregando cambios...`n"
Write-Host "El script ejecutara 'git add .' en $PAUSE_DURATION segundos."
Write-Host "Presiona Ctrl+C para cancelar...`n"
Start-Sleep -s $PAUSE_DURATION

Write-Host "Ejecutando: git add .`n"
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Fallo al agregar archivos (git add .)."
    exit
}
Write-Host "'git add .' completado con exito.`n"

# === PASO 3: Git COMMIT ===
Write-Host " Haciendo commit...`n"
$commit_message = Read-Host "Introduce el mensaje del commit (Enter para usar el predeterminado '$DEFAULT_COMMIT_MESSAGE')"
if (-not $commit_message) {
    $commit_message = $DEFAULT_COMMIT_MESSAGE
}

Write-Host "`nEl script ejecutara 'git commit' en $PAUSE_DURATION segundos."
Write-Host "Presiona Ctrl+C para cancelar...`n"
Start-Sleep -s $PAUSE_DURATION

Write-Host "Ejecutando: git commit -m '$commit_message'`n"
git commit -m "$commit_message"
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Fallo al ejecutar el commit (git commit -m '$commit_message')."
    exit
}
Write-Host "'git commit' completado con exito.`n"

# === PASO 4: Git PUSH ===
Write-Host " Enviando cambios al repositorio remoto...`n"
Write-Host "El script ejecutara 'git push' en $PAUSE_DURATION segundos."
Write-Host "Presiona Ctrl+C para cancelar...`n"
Start-Sleep -s $PAUSE_DURATION

Write-Host "Ejecutando: git push origin $GIT_BRANCH`n"
git push origin $GIT_BRANCH
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Fallo al enviar los cambios (git push)."
    exit
}
Write-Host "'git push' completado con exito.`n"

Write-Host "`n==========================================="
Write-Host "     PROCESO DE ACTUALIZACION DE $REPO_NAME FINALIZADO."
Write-Host "===========================================`n"

pause
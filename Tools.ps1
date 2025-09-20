function open() {
    $path = Get-Location
    powershell.exe -command Invoke-Item $path
}

function lightMode() {
    Write-Host "Disabling Dark Mode"
    $Theme = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    Set-ItemProperty $Theme AppsUseLightTheme -Value 1
    Start-Sleep 1
    Write-Host "Disabled"
}

function DarkMode() {
    Write-Host "Enabling Dark Mode"
    $Theme = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    Set-ItemProperty $Theme AppsUseLightTheme -Value 0
    Start-Sleep 1
    Write-Host "Enabled"
}

function removeFolder(){

# Script para mover todos os arquivos das subpastas para a pasta raiz
# Define o caminho da pasta raiz (altere conforme necessário)
$pastaRaiz = "C:\SuaPasta"

# Verifica se a pasta existe
if (!(Test-Path $pastaRaiz)) {
    Write-Host "Pasta não encontrada: $pastaRaiz" -ForegroundColor Red
    exit
}

Write-Host "Movendo arquivos para: $pastaRaiz" -ForegroundColor Green

# Busca todos os arquivos em todas as subpastas recursivamente
$arquivos = Get-ChildItem -Path $pastaRaiz -File -Recurse

$contador = 0
$conflitos = 0

foreach ($arquivo in $arquivos) {
    # Pula arquivos que já estão na pasta raiz
    if ($arquivo.DirectoryName -eq $pastaRaiz) {
        continue
    }
    
    $nomeArquivo = $arquivo.Name
    $destinoCompleto = Join-Path $pastaRaiz $nomeArquivo
    
    try {
        # Verifica se já existe um arquivo com o mesmo nome na raiz
        if (Test-Path $destinoCompleto) {
            # Cria um nome único adicionando timestamp
            $nomeBase = [System.IO.Path]::GetFileNameWithoutExtension($nomeArquivo)
            $extensao = [System.IO.Path]::GetExtension($nomeArquivo)
            $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
            $novoNome = "${nomeBase}_${timestamp}${extensao}"
            $destinoCompleto = Join-Path $pastaRaiz $novoNome
            
            Write-Host "Conflito de nome detectado. Renomeando para: $novoNome" -ForegroundColor Yellow
            $conflitos++
        }
        
        # Move o arquivo
        Move-Item -Path $arquivo.FullName -Destination $destinoCompleto -Force
        Write-Host "Movido: $($arquivo.FullName) -> $destinoCompleto" -ForegroundColor Cyan
        $contador++
        
    } catch {
        Write-Host "Erro ao mover arquivo $($arquivo.FullName): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`nProcesso concluído!" -ForegroundColor Green
Write-Host "Arquivos movidos: $contador" -ForegroundColor Green
Write-Host "Conflitos resolvidos: $conflitos" -ForegroundColor Yellow

# Remove pastas vazias (opcional)
$resposta = Read-Host "`nDeseja remover as pastas vazias? (S/N)"
if ($resposta -eq 'S' -or $resposta -eq 's') {
    Get-ChildItem -Path $pastaRaiz -Directory -Recurse | 
        Where-Object { (Get-ChildItem $_.FullName).Count -eq 0 } |
        Remove-Item -Force
    Write-Host "Pastas vazias removidas." -ForegroundColor Green
}

}
function bing(){
    $json = Get-Content -Path "C:\Users\Felipe\Documents\PowerShell\Word.json" -Raw | ConvertFrom-Json

    $nomes = $json.Name
    $minutesToWait = 60 * 5

    for ($i = 0; $i -lt $nomes.Count; $i++) {
        $indiceAleatorio = Get-Random -Minimum 0 -Maximum $nomes.Count
        $nomeEscolhido = $nomes[$indiceAleatorio]

        $dataHora = Get-Date
        Write-Output "$($dataHora.ToString('HH:mm')) Pesquisando: $nomeEscolhido"

        $url = "https://www.bing.com/search?q=$($nomeEscolhido)"
        Start-Process $url

        Start-Sleep -Seconds $minutesToWait
    }
}

function mouse() {
# Add the System.Windows.Forms assembly
Add-Type -AssemblyName System.Windows.Forms

# Set the new position of the mouse cursor (e.g., to coordinates X=500, Y=300)
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(500, 300)
}
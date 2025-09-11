function SpotifyUpdate {
    Write-Output "python.exe -m pip install --upgrade pip; pip install --upgrade spotdl;"
    python.exe -m pip install --upgrade pip; 
    pip install -U --force spotdl;
}

function Spotify($address, $threads = 3) {
    Write-Output "spotdl --save-file 'zsync.spotdl' sync $address --threads $threads"
    spotdl --save-file 'zsync.spotdl' sync $address --threads $threads
}

function SpotifySync($numberOfThreads = 1) {
    spotdl sync zsync.spotdl --threads $numberOfThreads
}

function SpotifySyncAll($numberOfThreads = 1) {
    Get-ChildItem  | ForEach-Object {
    $repoPath = $_.FullName
    $repoName = $_.Name

    if (Test-Path "$repoPath\zsync.spotdl") {
        Set-Location $repoPath
        Write-Host "`n$repoName" -ForegroundColor Yellow
        
        SpotifySync($numberOfThreads)
    }
    }
}

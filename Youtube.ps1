
function youtube($originalUrl, $videoQuality = "2K") {

    switch ($videoQuality.toupper()) {
        ("1440","2K") { $videoQuality = "1440" }
        ("1080","FULLHD") { $videoQuality = "1080" }
        ("720","HD") { $videoQuality = "720" }
        ("360","") { $videoQuality = "360" }
        ("4k","2160") { $videoQuality = "2160" }
        default { $videoQuality = "1440" }
    }

    echo "Video Quality: " $videoQuality

    youtubeTemp

    $url = $originalUrl
    if([string]::IsNullOrEmpty($url)){
        $url = Get-Clipboard
    }

	$urlWithoutParam = $url.Split("&")[0]

    echo $urlWithoutParam

    yt-dlp `
        --check-formats `
        --sponsorblock-remove sponsor,selfpromo `
        -f "bestvideo[height<=$videoQuality]+(ba[format_note*=original]/ba)" `
        -o '%(channel)s - %(title)s.%(ext)s' `
        -P "temp:/mnt/d/Downloads" `
        --sub-langs 'enUS,en,en-US,pt,ptBR,pt-BR' `
        --alias with-subs,--Xs '--X0 {0} --write-subs --embed-subs' `
        --alias without-subs,--Xn '--X0 {0} --no-write-subs --no-embed-subs' `
        --add-metadata `
        $urlWithoutParam
}

# Set-Alias -Name youtube -Value youtube2k -Scope Global

function youtubeTemp() {
    cd 'D:\Videos\Youtube Temp\'
}

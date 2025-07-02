
function youtube($originalUrl, $videoQuality = "1440") {

    echo "Video Quality: '$videoQuality'p" 

    youtubeTemp

    $tempDownloadPath = "D:\Downloads"

    if($IsLinux){
        $tempDownloadPath = "/mnt/d/Downloads"
    }   

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
        -P "temp:$tempDownloadPath" `
        --sub-langs 'enUS,en,en-US,pt,ptBR,pt-BR,br' `
        --embed-subs `
        --embed-thumbnail `
        --add-metadata `
        $urlWithoutParam
}

function youtube2k($originalUrl) {
    youtube $originalUrl "1440"
}

function youtube1440($originalUrl) {
    youtube $originalUrl "1440"
}

function youtubefullhd($originalUrl) {
    youtube $originalUrl "1080"
}

function youtubehd($originalUrl) {
    youtube $originalUrl "720"
}

function youtube360($originalUrl) {
    youtube $originalUrl "360"
}

function youtube4k($originalUrl) {
    youtube $originalUrl "2160"
}

# Set-Alias -Name youtube2k -Value youtube -Scope Global

function youtubeTemp() {
    if($IsLinux){
        cd '/mnt/d/Videos/Youtube Temp'
    }   

    if($IsWindows){
        cd 'D:\Videos\Youtube Temp\'
    }
}

function updateYoutube() {
    if($IsLinux){
        pipx upgrade yt-dlp
    }   

    if($IsWindows){
        pip install --upgrade yt-dlp
    }
}

function getSub($fileName, $subPosition) {
	
    $subFileName = [System.IO.Path]::GetFileNameWithoutExtension($filename) + ".srt"
	
    ffmpeg -i $fileName -map 0:s:$subPosition $subFileName
    Write-Output "ffmpeg -i $fileName -map 0:s:$subPosition $subFileName"
}

function getAllSub($subPosition) {

    $folderPath = Get-Location

    $fileNamesArray = Get-ChildItem -Path $folderPath -File | Select-Object -ExpandProperty Name

    Write-Output $fileNamesArray

    foreach ($fileName in $fileNamesArray) {
        $subFileName = [System.IO.Path]::GetFileNameWithoutExtension($filename) + ".srt"
        ffmpeg -i $fileName -map 0:s:$subPosition $subFileName
        Write-Output "ffmpeg -i $fileName -map 0:s:$subPosition $subFileName"
    }

}
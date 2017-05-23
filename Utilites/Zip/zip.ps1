param (
    [string]$pathToZipFolder,
    [string]$pathToZipFile,
    [string]$overwrite
)

Write-Verbose 'Entering zip.ps1'
Write-Verbose "pathToZipFolder = $pathToZipFolder"
Write-Verbose "pathToZipFile = $pathToZipFile"
Write-Verbose "overwrite = $overwrite"

Add-Type -A System.IO.Compression.FileSystem

# This is a hack since the agent passes this as a string.
if($overwrite -eq "true"){
    $overwrite = $true
}else{
    $overwrite = $false
}

if ($overwrite -and (Test-Path $pathToZipFile)){
    Write-Verbose "Removing the old file"
    Remove-Item $pathToZipFile
}

$destinationFolder = split-path $pathToZipFile -Parent
Write-Verbose "destinationFolder = $destinationFolder"
New-Item -ItemType Directory -Force -Path $destinationFolder

[IO.Compression.ZipFile]::CreateFromDirectory($pathToZipFolder, $pathToZipFile)

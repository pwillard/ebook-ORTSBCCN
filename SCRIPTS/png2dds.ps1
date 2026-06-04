param(
    [string]$Source = ".",
    [string]$Destination = ".\dds",
    [switch]$Recursive
)

Write-Host ""
Write-Host "PNG → DDS Texture Converter (Auto DXT)"
Write-Host "---------------------------------------"

# Verify ImageMagick
if (-not (Get-Command magick -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: ImageMagick not found in PATH" -ForegroundColor Red
    exit
}

# Create destination folder
if (!(Test-Path $Destination)) {
    New-Item -ItemType Directory -Path $Destination | Out-Null
}

# Collect PNG files
if ($Recursive) {
    $files = Get-ChildItem $Source -Filter *.png -Recurse
}
else {
    $files = Get-ChildItem $Source -Filter *.png
}

$total = $files.Count
$count = 0
$errors = 0

Write-Host "Found $total PNG files"
Write-Host ""

foreach ($file in $files) {

    $count++
    $output = Join-Path $Destination ($file.BaseName + ".dds")

    Write-Host ("[{0}/{1}] {2}" -f $count,$total,$file.Name) -ForegroundColor Cyan

    try {

        # Detect alpha channel
        $channels = magick identify -format "%[channels]" $file.FullName

        if ($channels -match "a") {
            $compression = "dxt5"
        }
        else {
            $compression = "dxt1"
        }

        Write-Host "   Compression: $compression"

        magick $file.FullName `
            -define dds:compression=$compression `
            -define dds:mipmaps=0 `
            $output

        if (Test-Path $output) {
            Write-Host "   SUCCESS" -ForegroundColor Green
        }
        else {
            Write-Host "   FAILED" -ForegroundColor Yellow
            $errors++
        }

    }
    catch {
        Write-Host "   ERROR: $_" -ForegroundColor Red
        $errors++
    }

}

Write-Host ""
Write-Host "Conversion Complete"
Write-Host "-------------------"
Write-Host "Total Files : $total"
Write-Host "Errors      : $errors"
Write-Host ""
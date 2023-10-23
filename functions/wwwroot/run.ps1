using namespace System.Net

param($Request, $TriggerMetadata)

# Path to your custom HTML file inside the wwwroot folder
$htmlPath = "$PSScriptRoot\..\wwwroot\index.html"

# Read the HTML file content
$body = Get-Content -Path $htmlPath -Raw

Push-GoodRequest -Body $body -ContentType "text/html"
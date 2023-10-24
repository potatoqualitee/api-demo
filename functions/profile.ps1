# Azure Functions profile.ps1
#
# This profile.ps1 will get executed every "cold start" of your Function App.
# "cold start" occurs when:
#
# * A Function App starts up for the very first time
# * A Function App starts up after being de-allocated due to inactivity
#
# You can define helper functions, run commands, or specify environment variables
# NOTE: any variables defined that are not environment variables will get reset after the first execution

$PSDefaultParameterValues["*:EnableException"] = $true
$PSDefaultParameterValues["*:Confirm"] = $false

# You can also define functions, aliases or script varaibles that can be referenced in any of your PowerShell functions.

# https://learn.microsoft.com/en-us/azure/azure-functions/manage-connections?tabs=csharp

Function Push-GoodRequest {
    [CmdletBinding()]
    param(
        [psobject[]]$Body,
        [hashtable]$Headers,
        [string]$ContentType = "application/json"
    )
    if ("$Body".Length -eq 1 -or "$Body" -eq "Null" -or $null -eq $Body) {
        Write-Host "Body length is 1 or Null"
        Push-OutputBinding -Name Response -Value (
            [HttpResponseContext]@{
                Headers     = $Headers
                StatusCode  = [HttpStatusCode]::OK
                Body        = $Body
                ContentType = $ContentType
            }
        )
    } else {
        Write-Host "Body length is greater than 1"
        if ($ContentType -match "json") {
            Write-Host "Converting to JSON"
            $newbody = ($Body) | ConvertTo-Json -Compress
        } else {
            $newbody = $Body | Select-Object -First 1
        }
        
        Push-OutputBinding -Name Response -Value (
            [HttpResponseContext]@{
                Headers     = $Headers
                StatusCode  = [HttpStatusCode]::OK
                Body        = "$newbody"
                ContentType = $ContentType
            }
        )
    }
}

Function Push-BadRequest {
    [CmdletBinding()]
    param(
        [psobject[]]$Body,
        [hashtable]$Headers
    )
    Push-OutputBinding -Name Response -Value (
        [HttpResponseContext]@{
            Headers    = $Headers
            StatusCode = [HttpStatusCode]::BadRequest
            Body       = ($Body) | ConvertTo-Json -Compress
        }
    )
}

function Get-ApiItem {
    return "Success"
}

Set-Alias New-ApiItem Get-ApiItem
Set-Alias Update-ApiItem Get-ApiItem
Set-Alias Remove-ApiItem Get-ApiItem

# Get the latest model
Set-TuneModelDefault -Latest
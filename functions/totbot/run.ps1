using namespace System.Net

param($Request, $TriggerMetadata)

switch ($Request.Method) {
    "GET" {
        Push-GoodRequest -Body (Invoke-TuneChat -Message "wyd")
    }
    "POST" {
        if ($Request.Form) {
            $command = $Request.Form["message"]
        }

        if (-not $command) {
            $command = $Request.Body
        }
        $command = $command.Replace("message=", "")
        Write-Host "SENDING $command"
        Push-GoodRequest -Body (Invoke-TuneChat -Message "$command")
    }
}

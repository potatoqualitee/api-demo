using namespace System.Net

param($Request, $TriggerMetadata)

switch ($Request.Method) {
    "GET" {
        $body = "
            <!DOCTYPE html>
            <html>
            <body>

            <h2>Ask Potato</h2>

            <form action='' method='post'>
            <label for='command'>Command:</label><br>
            <input type='text' id='command' name='command'><br>
            <input type='submit' value='Submit'>
            </form> 

            </body>
            </html>"
        
        Push-GoodRequest -Body $body -ContentType "text/html"
    }
    "post" {
        # if it came from the form
        $command = $Request.Form["command"].ToString()

        if (-not $command) {
            $command = $Request.Body.ToString()
        }
        Push-GoodRequest -Body (Invoke-TuneChat -Message $command)
    }
}

using namespace System.Net

param (
    $Request,
    $TriggerMetadata
)

$id = $Request.Params.id
$options = $Request.Params.options

switch ($Request.Method) {
    "post" {
        $prep = New-ApiItem -Body $Request.Body -Table $table
        $query = $prep.Query
        $parms = $prep.Parameters
    }
    "patch" {
        $prep = Update-ApiItem -Body $Request.Body -Table $table
        $query = $prep.Query
        $parms = $prep.Parameters
    }
    "delete" {
        $prep = Remove-ApiItem -Body $Request.Body -Table $table
        $query = $prep.Query
        $parms = $prep.Parameters
    }
}

if ($options -eq "whatever") {
    # this is a placeholder for you
    # to get creative.
}

if ($id -and $Request.Method -ne "delete") {
    $where += "id = @id"
    $parms.id = $id
}

try {
    $splat = @{
        Statement   = $query
        Where       = $where
        OrderBy     = $orderby
        Parms       = $parms
        ErrorAction = "Stop"
    }
    Push-GoodRequest -Body (Invoke-Query @splat)
} catch {
    Push-BadRequest -Body "$PSItem"
}

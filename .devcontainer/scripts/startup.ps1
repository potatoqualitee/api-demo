Write-Output "Installing some Linux packages"
sudo apt-get update
sudo apt-get install -y ca-certificates curl powershell-lts git

Write-Output "Time elapsed: $($time.Elapsed.TotalSeconds) seconds"
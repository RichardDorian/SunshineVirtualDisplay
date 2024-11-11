$config = Get-Content "$PSScriptRoot/fake-display.json" | ConvertFrom-Json
Set-DisplayPrimary -DisplayId $config.mainDisplayId
Disable-Display -DisplayId $config.fakeDisplayId
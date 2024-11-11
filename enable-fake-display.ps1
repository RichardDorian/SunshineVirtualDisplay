$moduleNeeded = !(Get-Module -ListAvailable -Name DisplayConfig)
if ($moduleNeeded) {
  Install-Module -Name DisplayConfig -Force
}

$displayId = (Get-Content "$PSScriptRoot/fake-display.json" | ConvertFrom-Json).fakeDisplayId
$width = if ($env:SUNSHINE_CLIENT_WIDTH) { $env:SUNSHINE_CLIENT_WIDTH } else { "1920" }
$height = if ($env:SUNSHINE_CLIENT_HEIGHT) { $env:SUNSHINE_CLIENT_HEIGHT } else { "1080" }
$fps = if ($env:SUNSHINE_CLIENT_FPS) { $env:SUNSHINE_CLIENT_FPS } else { "60" }
$hdr = $env:SUNSHINE_CLIENT_HDR -eq "true"

Enable-Display -DisplayId $displayId
Set-DisplayPrimary -DisplayId $displayId
Set-DisplayResolution -DisplayId $displayId -Width $width -Height $height
Set-DisplayRefreshRate -DisplayId $displayId -RefreshRate $fps
Set-DisplayHDR -DisplayId $displayId -EnableHDR:$hdr
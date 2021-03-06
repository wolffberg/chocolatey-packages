﻿$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera-beta/71.0.3770.97/win/Opera_beta_71.0.3770.97_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera-beta/71.0.3770.97/win/Opera_beta_71.0.3770.97_Setup_x64.exe'
  checksum       = '9cc877acb8fa35044c177a900513c47e4d3448460477bec4ea8cac7adafecca5'
  checksum64     = 'b8ac43523814f2a57682910847b5483ea2064481dbdb4d073689e1886045395c'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '71.0.3770.97'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}

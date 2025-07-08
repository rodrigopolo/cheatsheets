# Windows 11

## Setup after install

Chris Titus Tech's Windows Utility
```bat
irm "https://christitus.com/win" | iex
```

> **Sources:**
> * https://github.com/christitustech/winutil
> * https://youtu.be/6UQZ5oQg8XA

Install PowerShell 7
```bat
winget install --id Microsoft.Powershell --source winget
```

Install Package manager
```bat
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
irm get.scoop.sh | iex
```

Install `git` `fastfetch` and `wget`
```bat
scoop install git fastfetch wget
```

Install nerd fonts
```bat
scoop bucket add nerd-fonts
scoop install nerd-fonts/JetBrainsMono-NF-Mono 
```

Install Oh My Posh, restart PowerShell after
```bat
winget install JanDeDobbeleer.OhMyPosh -s winget
```

Download our custom theme
```bat
cd $env:POSH_THEMES_PATH
wget https://raw.githubusercontent.com/rodrigopolo/cheatsheets/refs/heads/master/rodrigopolo.omp.json -O rodrigopolo.omp.json
```

Add the theme to the profile
```bat
New-Item -Path $PROFILE -Type File -Force
notepad $PROFILE
```

Paste this
```bat
:: fastfetch -c examples/7.jsonc
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\rodrigopolo.omp.json" | Invoke-Expression
```
> **Sources**:
> * [Make Windows Terminal Look Better | Oh My Posh Guide](https://youtu.be/G6GbXGo4wo)

Git
```bat
ssh-keygen -t ed25519 -C "user@mail.com"
ssh-copy-id -i ~/.ssh/id_rsa.pub user@server
```

## Other stuff
History
```bat
Get-Content (Get-PSReadLineOption).HistorySavePath
```

## Tauri/Rust Dev

Install node
```bat
scoop install nodejs
```

Download and install Rust manualy, it will install Microsoft C++ build tools for Visual Studio
https://www.rust-lang.org/tools/install


Install compilig tools (Rust installs this)
```bat
:: X86
winget install Microsoft.VisualStudio.2022.BuildTools --override "--quiet --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended"

:: ARM64
winget install Microsoft.VisualStudio.2022.BuildTools --override "--quiet --add Microsoft.VisualStudio.Workload.VCTools --add Microsoft.VisualStudio.Component.VC.Tools.ARM64 --includeRecommended"
```

Make sure the target is X86
```bat
rustup default stable-x86_64-pc-windows-msvc
```

Index files
```bat
Get-ChildItem -Recurse -File | ForEach-Object { $_.FullName } >  ~/Desktop/allfiles.txt
```

Change architecture
```bat
rustup default stable-x86_64-pc-windows-msvc
```

Add path
```bat
$newPath = "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Tools\MSVC\14.44.35207\bin\Hostarm64\arm64"
$currentPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
[System.Environment]::SetEnvironmentVariable("Path", "$currentPath;$newPath", "User")
```

Get architecture of an `.exe`
```bat
function Get-ExeArchitecture($path) {
    $bytes = [System.IO.File]::ReadAllBytes($path)
    $peHeaderOffset = [System.BitConverter]::ToInt32($bytes, 60)
    $machineType = [System.BitConverter]::ToUInt16($bytes, $peHeaderOffset + 4)
    switch ($machineType) {
        0x014c { "x86 (32-bit)" }
        0x8664 { "x64 (64-bit)" }
        0xAA64 { "ARM64" }
        0x01c4 { "ARM" }
        default { "Unknown ($machineType)" }
    }
}

Get-ExeArchitecture "C:\path\to\your\file.exe"
```

Compile
```bat
npm run tauri build -- --target aarch64-pc-windows-msvc
```

Winget
https://github.com/microsoft/winget-cli/releases


```bat
Add-AppxPackage C:\Users\rpolo\Downloads\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
```

### Other sources
* The Perfect Windows 11 Install  
https://youtu.be/6UQZ5oQg8XA

* How To Setup Windows  
https://youtu.be/0PA1wgdMeeI

* Download Windows 11 for Arm-based PCs  
https://www.microsoft.com/en-us/software-download/windows11arm64

* Download Windows 11  
https://www.microsoft.com/en-us/software-download/windows11



### Videos


* How To Clean Install macOS Sequoia on Unsupported Macs (2007-2019) - Step By Step Guide  
  https://www.youtube.com/watch?v=OzAvWKUKmJE

* Different Ways to automatically logon Windows 11 #auto #logon #your #Windows11 #PC #nopassword  
  https://www.youtube.com/watch?v=SjFRBw_5eNc

* Install Windows 11 on Your Mac: Easy Boot Camp Guide (Intel, 2012+ Models)  
  https://www.youtube.com/watch?v=Bh0d1egaSI0

* 4,1-7,1 Windows 11 Install! - Mac Pro Series S.4 EP.8  
  https://www.youtube.com/watch?v=cMiIOy8ptRc


#oh-my-posh init pwsh | Invoke-Expression
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\catppuccin_mocha.omp.json" | Invoke-Expression
oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH\dracula.omp.json | Invoke-Expression

#PSReadLine
#Import-Module PSReadLine
set-psreadlineoption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Chord Ctrl-p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord Ctrl-n -Function HistorySearchForward

# Set-PSReadLineKeyHandler -Key Ctrl+t -ScriptBlock {
#   fzf-open
# }
# function fzf-open {
#   $selection = fzf -m --preview 'bat --style=numbers --color=always {}'

#   foreach ($item in $selection) {
#     if (Test-Path -PathType Container $item) {
#       Set-Location $item
#     } else {
#       Invoke-Item $item
#     }
#   }
# }

#zoxide
Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })

#terminal-icon
Import-Module -Name Terminal-Icons

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.

# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#  Import-Module "$ChocolateyProfile"
# }

$Env:YAZI_FILE_ONE = 'C:\Program Files\Git\usr\bin\file.exe'

function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}

#winfetch

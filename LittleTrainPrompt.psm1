. $PSScriptRoot\Components.ps1
. $PSScriptRoot\Options.ps1
. $PSScriptRoot\Segments.ps1
. $PSScriptRoot\Styles.ps1
. $PSScriptRoot\Utilities.ps1

function RenderInitialSymbol {
    param (
        [parameter(Mandatory=$true)]
        [ConsoleColor]$Color
    )
    $style = Get-CurrentPromptStyle
    if ($style.RenderInitialSymbol) {
        if ($style.ReverseColor) {
            Write-Host $style.InitialSymbol -ForegroundColor $Color -BackgroundColor Black -NoNewline
        } else {
            Write-Host $style.InitialSymbol -ForegroundColor Black -BackgroundColor $Color -NoNewline
        }
    }
}

function RenderSeparatorSymbol {
    param (
        [parameter(Mandatory=$true)]
        [ConsoleColor]$Before,
        [parameter(Mandatory=$true)]
        [ConsoleColor]$After
    )
    if ($Before -eq $After) {
        Write-Host (Get-InnerSeparatorSymbol) -ForegroundColor Gray -BackgroundColor $Before -NoNewline
    } else {
        Write-Host (Get-CurrentPromptStyle).SegmentSeparator -ForegroundColor $Before -BackgroundColor $After -NoNewline
    }
}

function RenderPromptSymbol {
    $colorPromptSymbol = Get-PromptOption PromptSymbolColor Green
    $colorElevatedSymbol = Get-PromptOption ElevatedSymbolColor Yellow
    $symbolPrompt = Get-PromptOption PromptSymbol '$'
    $symbolElevated = Get-PromptOption ElevatedSymbol '#'
    if (Test-IsElevated) {
        Write-Host $symbolElevated -ForegroundColor $colorElevatedSymbol -NoNewline
    } else {
        Write-Host $symbolPrompt -ForegroundColor $colorPromptSymbol -NoNewline
    }
}

function InvokeComponents {
    return Get-PromptComponentOrder | ForEach-Object {
        (Get-PromptComponent $_).InvokeReturnAsIs()
    } | Where-Object { -not $_.IsEmpty() }
}

function RenderPrompt {
    Update-LastExecutionStatus
    if ((-not (Test-HasNewExecutedCommand)) -or ((Get-CurrentPlatform) -ne 'Win32NT')) {
        Write-Host
    }
    try {
        if ((Get-PromptComponentOrder).Count -gt 0) {
            $segments = InvokeComponents
            RenderInitialSymbol $segments[0].BackgroundColor
            for ($i = 0; $i -lt $segments.Count; $i++) {
                $segments[$i].Render()
                if (($i + 1) -eq $segments.Count) {
                    RenderSeparatorSymbol $segments[$i].BackgroundColor Black
                } else {
                    RenderSeparatorSymbol $segments[$i].BackgroundColor $segments[$i + 1].BackgroundColor
                }
            }
            Write-Host
        }
        RenderPromptSymbol
    } catch {
        Write-Host 'Error occurred. Check your settings.' -ForegroundColor Red
        Write-Host "$(Get-Location)>" -NoNewline
    }
    Update-ExecutedCommandCount
    Update-ErrorCount
}

function Initialize-LittleTrainPrompt {
    Set-PSReadLineOption -PromptText ''
    Set-Item -Path function:prompt -Options 'None'
    function global:prompt {
        RenderPrompt
        return ' '
    }
    Set-Item -Path function:prompt -Options 'ReadOnly'
}

. $PSScriptRoot\LoadPresets.ps1

Initialize-LittleTrainPrompt

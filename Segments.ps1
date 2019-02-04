class TextSegment {
    [string]$Text
    [ConsoleColor]$Color

    TextSegment([string]$Text, [ConsoleColor]$Color) {
        $this.Text = $Text
        $this.Color = $Color
    }
}

class PromptSegment {
    [TextSegment[]]$TextSegments = @()
    [ConsoleColor]$BackgroundColor
    [ConsoleColor]$ForegroundColor

    PromptSegment([ConsoleColor]$BackgroundColor, [ConsoleColor]$ForegroundColor) {
        $this.BackgroundColor = $BackgroundColor
        $this.ForegroundColor = $ForegroundColor
    }

    [void]Append([string]$Text) {
        $this.TextSegments += [TextSegment]::new($Text, $this.ForegroundColor)
    }

    [void]Append([string]$Text, [ConsoleColor]$TextColor) {
        $this.TextSegments += [TextSegment]::new($Text, $TextColor)
    }

    [bool]IsEmpty() {
        return $this.TextSegments.Count -eq 0
    }

    [void]Render() {
        if (-not $this.IsEmpty()) {
            Write-Host ' ' -NoNewline -BackgroundColor $this.BackgroundColor
            $this.TextSegments | ForEach-Object {
                Write-Host $_.Text -NoNewline -BackgroundColor $this.BackgroundColor -ForegroundColor $_.Color
            }
            Write-Host ' ' -NoNewline -BackgroundColor $this.BackgroundColor
        }
    }
}

function New-PromptSegment {
    param (
        [parameter(Mandatory=$true)][ConsoleColor]$BackgroundColor,
        [parameter(Mandatory=$true)][ConsoleColor]$ForegroundColor
    )
    return [PromptSegment]::new($BackgroundColor, $ForegroundColor)
}

Export-ModuleMember -Function @(
    'New-PromptSegment'
)

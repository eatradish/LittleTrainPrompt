Register-PromptComponent Path {
    $colorBackground = Get-PromptOption PathBackgroundColor DarkBlue
    $colorForeground = Get-PromptOption PathForegroundColor White
    $colorSeparator = Get-PromptOption PathSeparatorColor Gray
    $colorFileSystem = Get-PromptOption PathFileSystemColor DarkMagenta
    $colorOthers = Get-PromptOption PathOthersColor DarkYellow

    $symbolHome = Get-PromptOption PathHomeSymbol ([char]::ConvertFromUtf32(0xF7DB))
    $symbolDrive = Get-PromptOption PathDriveSymbol ([char]::ConvertFromUtf32(0xF7C9))
    $symbolOthers = Get-PromptOption PathOthersSymbol ([char]::ConvertFromUtf32(0xF013))
    $symbolFileSystem = Get-PromptOption PathFileSystemSymbol ([char]::ConvertFromUtf32(0xE5FF))

    $limit = [uint16](Get-PromptOption PathDisplayLengthLimit 2)
    $ellipsis = "$([char]::ConvertFromUtf32(0xB7))$([char]::ConvertFromUtf32(0xB7))$([char]::ConvertFromUtf32(0xB7))"
    $path = $(Get-Location).Path
    $slash = '\'
    if ($path.Contains('/')) {
        $slash = '/'
    }
    if ($path.EndsWith($slash)) {
        $path = $path.Substring(0, $path.Length - 1)
    }
    $drive = Get-CurrentDriveName

    $segment = New-PromptSegment $colorBackground $colorForeground

    function InsertSeparator {
        $segment.Append(" $(Get-InnerSeparatorSymbol) ", $colorSeparator)
    }

    function InsertEllipsis {
        InsertSeparator
        $segment.Append($ellipsis)
    }

    function RenderRelativePath {
        param (
            [parameter(Mandatory=$true)][string]$Path
        )
        $list = $Path.Split($slash)
        if ($list.Count -gt $limit) {
            InsertEllipsis
        }
        $list.Where({ $true }, 'Last', $limit) | ForEach-Object {
            InsertSeparator
            $segment.Append($_)
        }
    }

    if ($path.StartsWith($HOME)) {
        $segment.Append("$symbolHome $((Get-Item $HOME).Name)")
        if ($path.Length -gt $HOME.Length) {
            RenderRelativePath $path.Substring($HOME.Length + 1)
        }
    } elseif ($drive -eq '/') {
        $segment.Append('/')
        if ($path.Length -gt 1) {
            RenderRelativePath $path.Substring(1)
        }
    } else {
        if ($drive.Length -eq 1) {
            $segment.Append("$symbolDrive ${drive}:")
            if ($path.Length -gt 2) {
                RenderRelativePath $path.Substring(3)
            }
        } else {
            if ((Get-CurrentDriveType) -eq 'FileSystem') {
                $segment.BackgroundColor = $colorFileSystem
                $segment.Append($symbolFileSystem)
            } else {
                $segment.BackgroundColor = $colorOthers
                $segment.Append($symbolOthers)
            }
            $segment.Append(" ${drive}:")
            if ($path.Length -gt $drive.Length + 2) {
                RenderRelativePath $path.Substring($drive.Length + 2)
            }
        }
    }

    return $segment
}

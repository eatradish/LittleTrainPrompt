Register-PromptComponent Writability {
    $background = Get-PromptOption WritabilityBackgroundColor DarkRed
    $foreground = Get-PromptOption WritabilityForegroundColor White
    $symbol = Get-PromptOption ReadOnlySymbol ([char]::ConvertFromUtf32(0xF023))
    $segment = New-PromptSegment $background $foreground
    if (
        ((Get-CurrentDriveType) -eq 'Registry') -or
        ((Get-CurrentDriveType) -eq 'FileSystem')
    ) {
        $testFile = New-Guid
        try {
            New-Item $testFile -ErrorAction Stop | Out-Null
            Remove-Item $testFile
        } catch {
            $segment.Append($symbol)
        }
    }
    return $segment
}

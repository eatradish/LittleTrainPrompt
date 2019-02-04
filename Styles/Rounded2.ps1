$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0B4)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0B5)
$style.InitialSymbol = [char]::ConvertFromUtf32(0xE0B6)
$style.RenderInitialSymbol = $true
$style.ReverseColor = $true
Add-PromptStyle Rounded2 $style

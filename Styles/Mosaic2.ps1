$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0C6)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0C6)
$style.InitialSymbol = [char]::ConvertFromUtf32(0xE0C6)
$style.RenderInitialSymbol = $true
Add-PromptStyle Mosaic2 $style

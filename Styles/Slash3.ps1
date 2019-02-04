$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0B8)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0B9)
$style.InitialSymbol = [char]::ConvertFromUtf32(0xE0B8)
$style.RenderInitialSymbol = $true
Add-PromptStyle Slash3 $style

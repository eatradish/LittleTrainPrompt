$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0BC)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0BD)
$style.InitialSymbol = [char]::ConvertFromUtf32(0xE0BC)
$style.RenderInitialSymbol = $true
Add-PromptStyle Slash4 $style

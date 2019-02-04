$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0C0)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0C1)
$style.InitialSymbol = [char]::ConvertFromUtf32(0xE0C2)
$style.RenderInitialSymbol = $true
$style.ReverseColor = $true
Add-PromptStyle Fire2 $style

$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0BC)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0BD)
Add-PromptStyle Slash2 $style

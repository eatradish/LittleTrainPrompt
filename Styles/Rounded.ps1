$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0B4)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0B5)
Add-PromptStyle Rounded $style

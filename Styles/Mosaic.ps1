$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0C6)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0C6)
Add-PromptStyle Mosaic $style

$style = New-PromptStyle
$style.SegmentSeparator = [char]::ConvertFromUtf32(0xE0C0)
$style.InnerSeparator = [char]::ConvertFromUtf32(0xE0C1)
Add-PromptStyle Fire $style

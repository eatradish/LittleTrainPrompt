$style = New-PromptStyle
$style.InitialSymbol = [char]::ConvertFromUtf32(0xE0B2)
$style.RenderInitialSymbol = $true
$style.ReverseColor = $true
Add-PromptStyle Powerline3 $style

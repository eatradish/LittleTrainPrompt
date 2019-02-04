$style = New-PromptStyle
$style.InitialSymbol = [char]::ConvertFromUtf32(0xE0B0)
$style.RenderInitialSymbol = $true
Add-PromptStyle Powerline2 $style

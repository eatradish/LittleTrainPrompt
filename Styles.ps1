class PromptStyle {
    [string]$SegmentSeparator = [char]::ConvertFromUtf32(0xE0B0)
    [string]$InnerSeparator = [char]::ConvertFromUtf32(0xE0B1)
    [string]$InitialSymbol = ''
    [bool]$RenderInitialSymbol = $false
    [bool]$ReverseColor = $false
}

$PromptStyleInfo = @{
    PromptStyles = @{
        Powerline = [PromptStyle]::new()
    }
    CurrentPromptStyle = 'Powerline'
}

function New-PromptStyle {
    return [PromptStyle]::new()
}

function Add-PromptStyle {
    param (
        [parameter(Mandatory=$true)]
        [string]$Name,
        [parameter(Mandatory=$true)]
        [PromptStyle]$Style
    )
    if ($PromptStyleInfo.PromptStyles.ContainsKey($Name)) {
        throw "Style '$Name' already exists."
    }
    $PromptStyleInfo.PromptStyles[$Name] = $Style
}

function Get-PromptStyle {
    param (
        [string]$Name
    )
    if ($Name.Length -gt 0) {
        return $PromptStyleInfo.PromptStyles[$Name]
    }
    return $PromptStyleInfo.PromptStyles
}

function Remove-PromptStyle {
    param (
        [parameter(Mandatory=$true)]
        [string]$Name
    )
    if (-not $PromptStyleInfo.PromptStyles.ContainsKey($Name)) {
        throw "Style '$Name' does not exist."
    }
    if ($Name -eq $PromptStyleInfo.CurrentPromptStyle) {
        throw "Style '$Name' is currently in use."
    }
    $PromptStyleInfo.PromptStyles.Remove($Name)
}

function Get-CurrentPromptStyle {
    return $PromptStyleInfo.PromptStyles[$PromptStyleInfo.CurrentPromptStyle]
}

function Set-CurrentPromptStyle {
    param (
        [parameter(Mandatory=$true)]
        [string]$Name
    )
    if (-not $PromptStyleInfo.PromptStyles.ContainsKey($Name)) {
        throw "Style '$Name' does not exist."
    }
    $PromptStyleInfo.CurrentPromptStyle = $Name
}

function Get-CurrentPromptStyleName {
    return $PromptStyleInfo.CurrentPromptStyle
}

function Get-InnerSeparatorSymbol {
    $PromptStyleInfo.PromptStyles[$PromptStyleInfo.CurrentPromptStyle].InnerSeparator
}

Export-ModuleMember -Function @(
    'New-PromptStyle',
    'Add-PromptStyle',
    'Get-PromptStyle',
    'Remove-PromptStyle',
    'Get-CurrentPromptStyle',
    'Set-CurrentPromptStyle',
    'Get-CurrentPromptStyleName',
    'Get-InnerSeparatorSymbol'
)

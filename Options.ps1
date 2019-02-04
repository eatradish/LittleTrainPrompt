$PromptOptions = @{}

function Find-PromptOption {
    return ($args | ForEach-Object { $keys = $PromptOptions.Keys } {
        $current = ([string]$_).ToLower()
        $keys = $keys.Where({
            $_.ToLower().Contains($current)
        })
    } { $keys } | ForEach-Object { $result = @{} } {
        $result[$_] = $PromptOptions[$_]
    } { $result })
}

function Get-PromptOption {
    param (
        [string]$Name,
        $FallbackValue
    )
    if ($Name.Length -gt 0) {
        if ($PromptOptions.ContainsKey($Name)) {
            return $PromptOptions[$Name]
        }
        if ($null -ne $FallbackValue) {
            $PromptOptions[$Name] = $FallbackValue
            return $FallbackValue
        }
    } else {
        return $PromptOptions
    }
}

function Set-PromptOption {
    param (
        [parameter(Mandatory=$true)]
        [string]$Name,
        [parameter(Mandatory=$true)]
        $Value
    )
    $PromptOptions[$Name] = $Value
}

function Remove-PromptOption {
    param (
        [parameter(Mandatory=$true)]
        [string]$Name
    )
    if (-not $PromptOptions.ContainsKey($Name)) {
        throw "Option '$Name' does not exist."
    }
    $PromptOptions.Remove($Name)
}

Export-ModuleMember -Function @(
    'Find-PromptOption',
    'Get-PromptOption',
    'Set-PromptOption',
    'Remove-PromptOption'
)

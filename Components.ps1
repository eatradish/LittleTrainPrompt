$PromptComponentInfo = @{
    PromptComponents = @{}
    ComponentOrder = @()
}

function Get-PromptComponent {
    param (
        [string]$Name
    )
    if ($Name.Length -gt 0) {
        return $PromptComponentInfo.PromptComponents[$Name]
    }
    return $PromptComponentInfo.PromptComponents
}

function Get-PromptComponentOrder {
    return $PromptComponentInfo.ComponentOrder
}

function Set-PromptComponentOrder {
    param (
        [parameter(Mandatory=$true)]
        [AllowEmptyCollection()]
        [string[]]$Order
    )
    if (($Order | Where-Object { -not $PromptComponentInfo.PromptComponents.ContainsKey($_) }).Count -gt 0) {
        throw "One or more specified components do not exist."
    }
    $PromptComponentInfo.ComponentOrder = $Order
}

function Register-PromptComponent {
    param (
        [parameter(Mandatory=$true)]
        [string]$Name,
        [parameter(Mandatory=$true)]
        [scriptblock]$Component
    )
    if ($PromptComponentInfo.PromptComponents.ContainsKey($Name)) {
        throw "Component '$Name' already exists."
    }
    if ($Component.InvokeReturnAsIs().GetType().FullName -ne 'PromptSegment') {
        throw "This component seems not working."
    }
    $PromptComponentInfo.PromptComponents[$Name] = $Component
}

function Unregister-PromptComponent {
    param (
        [parameter(Mandatory=$true)]
        [string]$Name
    )
    if (-not $PromptComponentInfo.PromptComponents.ContainsKey($Name)) {
        throw "Component '$Name' does not exist."
    }
    if ($PromptComponentInfo.ComponentOrder.Contains($Name)) {
        throw "Component '$Name' is currently in use."
    }
    $PromptComponentInfo.PromptComponents.Remove($Name)
}

Export-ModuleMember -Function @(
    'Get-PromptComponent',
    'Get-PromptComponentOrder',
    'Set-PromptComponentOrder',
    'Register-PromptComponent',
    'Unregister-PromptComponent'
)

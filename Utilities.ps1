$StatusInfo = @{
    ErrorCount = $Global:Error.Count
    ExecutedCommandCount = (Get-History).Count
    LastExecutionStatus = $true
}

function Update-LastExecutionStatus {
    $StatusInfo.LastExecutionStatus = ($Global:Error.Count -le $StatusInfo.ErrorCount) -and ($LASTEXITCODE -le 0)
    $LASTEXITCODE = 0
}

function Update-ExecutedCommandCount {
    $StatusInfo.ExecutedCommandCount = (Get-History).Count
}

function Update-ErrorCount {
    $StatusInfo.ErrorCount = $Global:Error.Count
}

function Get-LastExecutionStatus {
    return $StatusInfo.LastExecutionStatus
}

function Get-LastExecutedCommand {
    $history = Get-History
    return $history[$history.Count - 1]
}

function Test-IsElevated {
    return $StatusInfo.IsElevated
}

function Test-HasNewExecutedCommand {
    return (Get-History).Count -gt $StatusInfo.ExecutedCommandCount
}

function Get-CurrentDriveName {
    return $(Get-Location).Drive.Name
}

function Get-CurrentDriveType {
    return $(Get-Location).Drive.Provider.Name
}

function Get-CurrentPlatform {
    return [System.Environment]::OSVersion.Platform
}

function CheckIdentity {
    if ((Get-CurrentPlatform) -eq 'Win32NT') {
        $identity = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
        return $identity.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    } elseif ((Get-CurrentPlatform) -eq 'Unix') {
        return $(whoami) -eq 'root'
    }
}

$StatusInfo.IsElevated = CheckIdentity

Export-ModuleMember -Function @(
    'Get-LastExecutionStatus',
    'Get-LastExecutedCommand',
    'Test-IsElevated',
    'Test-HasNewExecutedCommand',
    'Get-CurrentDriveName',
    'Get-CurrentDriveType',
    'Get-CurrentPlatform'
)

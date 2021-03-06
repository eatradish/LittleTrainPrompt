@{
    RootModule = 'LittleTrainPrompt.psm1'
    ModuleVersion = '0.1'
    GUID = '642adc8b-610d-4e7b-a13d-a54801942353'
    Author = 'Namorzyny'
    Copyright = '(c) 2019 Namorzyny. All rights reserved.'
    Description = ''
    PowerShellVersion = '5.0'
    FunctionsToExport = @(
        'Get-PromptComponent',
        'Get-PromptComponentOrder',
        'Set-PromptComponentOrder',
        'Register-PromptComponent',
        'Unregister-PromptComponent',
        'Find-PromptOption',
        'Get-PromptOption',
        'Set-PromptOption',
        'Remove-PromptOption'
        'New-PromptSegment'
        'New-PromptStyle',
        'Add-PromptStyle',
        'Get-PromptStyle',
        'Remove-PromptStyle',
        'Get-CurrentPromptStyle',
        'Set-CurrentPromptStyle',
        'Get-CurrentPromptStyleName',
        'Get-InnerSeparatorSymbol'
        'Get-LastExecutionStatus',
        'Get-LastExecutedCommand',
        'Test-IsElevated',
        'Test-HasNewExecutedCommand',
        'Get-CurrentDriveName',
        'Get-CurrentDriveType',
        'Get-CurrentPlatform'
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    PrivateData = @{
        PSData = @{
            # Tags = @()
            # LicenseUri = ''
            # ProjectUri = ''
            # IconUri = ''
            # ReleaseNotes = ''
        }
    }
}

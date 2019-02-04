Get-ChildItem $PSScriptRoot\Components | ForEach-Object { . $_.FullName }
Get-ChildItem $PSScriptRoot\Styles | ForEach-Object { . $_.FullName }

Set-PromptComponentOrder @('ExecutionResult', 'Clock', 'Path', 'Git', 'Writability')

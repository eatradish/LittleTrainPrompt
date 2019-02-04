Register-PromptComponent ExecutionResult {
    $colorError = Get-PromptOption ExecutionErrorColor DarkRed
    $colorSuccess = Get-PromptOption ExecutionSuccessColor DarkGreen
    $colorForeground = Get-PromptOption ExecutionResultForegroundColor White

    $symbolError = Get-PromptOption ExecutionErrorSymbol ([char]::ConvertFromUtf32(0xF00D))
    $symbolSuccess = Get-PromptOption ExecutionSuccessSymbol ([char]::ConvertFromUtf32(0xF00C))

    $threshold = Get-PromptOption ExecutionDurationDisplayThreshold 0

    $segment = New-PromptSegment $colorSuccess $colorForeground

    if (Test-HasNewExecutedCommand) {
        if (Get-LastExecutionStatus) {
            $segment.Append("$symbolSuccess")
        } else {
            $segment.BackgroundColor = $colorError
            $segment.Append("$symbolError")
        }
        $lastCommand = Get-LastExecutedCommand
        $executionDuration = New-TimeSpan -Start $lastCommand.StartExecutionTime -End $lastCommand.EndExecutionTime
        if ($executionDuration.TotalSeconds -gt $threshold) {
            if ($executionDuration.TotalMilliseconds -lt 1000) {
                $segment.Append(" $([int]$executionDuration.TotalMilliseconds)ms")
            } else {
                $segment.Append(' ')
                $hours = [int]$executionDuration.TotalHours
                $minutes = $executionDuration.Minutes
                $seconds = $executionDuration.Seconds
                if ($hours -gt 0) {
                    $segment.Append("${hours}h")
                }
                if ($minutes -gt 0) {
                    $segment.Append("${minutes}m")
                }
                if ($seconds -gt 0) {
                    $segment.Append("${seconds}s")
                }
            }
        }
    }

    return $segment
}

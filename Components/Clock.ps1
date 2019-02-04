Register-PromptComponent Clock {
    $background = Get-PromptOption ClockBackgroundColor White
    $foreground = Get-PromptOption ClockForegroundColor Black
    $format = Get-PromptOption ClockDisplayFormat 'H:mm'
    $segment = New-PromptSegment $background $foreground
    $segment.Append($(Get-Date -Format $format))
    return $segment
}

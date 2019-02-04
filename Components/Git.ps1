Register-PromptComponent Git {
    $symbolBranch = Get-PromptOption GitBranchSymbol ([char]::ConvertFromUtf32(0xE0A0))
    $symbolCommit = Get-PromptOption GitCommitSymbol ([char]::ConvertFromUtf32(0xFC16))
    $symbolClean = Get-PromptOption GitCleanSymbol ([char]::ConvertFromUtf32(0xF00C))
    $symbolStaged = Get-PromptOption GitStagedSymbol ([char]::ConvertFromUtf32(0xF067))
    $symbolUnstaged = Get-PromptOption GitUnstagedSymbol ([char]::ConvertFromUtf32(0xF040))
    $symbolUnmerged = Get-PromptOption GitUnmergedSymbol ([char]::ConvertFromUtf32(0xF00D))
    $symbolUntracked = Get-PromptOption GitUntrackedSymbol ([char]::ConvertFromUtf32(0xF005))
    $symbolAhead = Get-PromptOption GitAheadSymbol ([char]::ConvertFromUtf32(0xF55D))
    $symbolBehind = Get-PromptOption GitBehindSymbol ([char]::ConvertFromUtf32(0xF545))

    $colorBackground = Get-PromptOption GitBackgroundColor White
    $colorForeground = Get-PromptOption GitForegroundColor Black
    $colorClean = Get-PromptOption GitCleanColor DarkGreen
    $colorStaged = Get-PromptOption GitStagedColor DarkBlue
    $colorUnstaged = Get-PromptOption GitUnstagedColor DarkYellow
    $colorUnmerged = Get-PromptOption GitUnmergedColor DarkRed
    $colorUntracked = Get-PromptOption GitUntrackedColor DarkMagenta
    $colorRemoteStatus = Get-PromptOption GitRemoteStatusColor DarkCyan

    $segment = New-PromptSegment $colorBackground $colorForeground

    function IsInRepository {
        $current = Get-Item .
        while ($null -ne $current) {
            if (Test-Path ($current.FullName + '\.git') -PathType Container) {
                return $true
            }
            $current = $current.Parent
        }
        return $false
    }

    if ((Get-CurrentDriveType) -eq 'FileSystem') {
        if (IsInRepository) {
            try {
                $statusInfo = git status
            } catch {
                return $segment
            }
            $branchInfo = $statusInfo[0]
            $statusInfo = $statusInfo -join "`n"
            if ($branchInfo.StartsWith('On branch')) {
                $segment.Append("$symbolBranch $($branchInfo.Substring(10))")
            } elseif ($branchInfo.StartsWith('HEAD detached from')) {
                $segment.Append("$symbolCommit $($(git rev-parse HEAD).Substring(0, 7))")
            } elseif ($branchInfo.StartsWith('HEAD detached at')) {
                $segment.Append("$symbolCommit $($branchInfo.Substring(17))")
            }
            $hasStagedChanges = $statusInfo.Contains('Changes to be committed')
            $hasUnstagedChanges = $statusInfo.Contains('Changes not staged for commit')
            $hasUntrackedFiles = $statusInfo.Contains('Untracked files')
            $hasUnmergedPaths = $statusInfo.Contains('Unmerged paths')
            $isClean = -not ($hasStagedChanges -or $hasUnstagedChanges -or $hasUntrackedFiles -or $hasUnmergedPaths)
            if ($isClean) {
                $segment.Append(" $symbolClean", $colorClean)
            } else {
                if ($hasUnmergedPaths) {
                    $segment.Append(" $symbolUnmerged", $colorUnmerged)
                }
                if ($hasStagedChanges) {
                    $segment.Append(" $symbolStaged", $colorStaged)
                }
                if ($hasUnstagedChanges) {
                    $segment.Append(" $symbolUnstaged", $colorUnstaged)
                }
                if ($hasUntrackedFiles) {
                    $segment.Append(" $symbolUntracked", $colorUntracked)
                }
            }
            if ($statusInfo.Contains('Your branch is ahead')) {
                $segment.Append(" $symbolAhead", $colorRemoteStatus)
            } elseif ($statusInfo.Contains('Your branch is behind')) {
                $segment.Append(" $symbolBehind", $colorRemoteStatus)
            } elseif ($statusInfo.Contains('have diverged')) {
                $segment.Append(" ${symbolAhead}${symbolBehind}", $colorRemoteStatus)
            }
        }
    }

    return $segment
}

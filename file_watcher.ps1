# PowerShell script to watch for file changes and auto-push to GitHub
# Run this in PowerShell: .\file_watcher.ps1

$watchFolder = "C:\Users\Ege\social_democracy_Anatolian_Sunrise-2\source"
$repoPath = "C:\Users\Ege\social_democracy_Anatolian_Sunrise-2"

Write-Host "Starting file watcher for auto-push to GitHub..." -ForegroundColor Green
Write-Host "Watching folder: $watchFolder" -ForegroundColor Yellow

$FileSystemWatcher = New-Object System.IO.FileSystemWatcher
$FileSystemWatcher.Path = $watchFolder
$FileSystemWatcher.Filter = "*.dry"
$FileSystemWatcher.IncludeSubdirectories = $true
$FileSystemWatcher.EnableRaisingEvents = $true

# Define the action to take when a file is changed
$Action = {
    $path = $Event.SourceEventArgs.FullPath
    $name = $Event.SourceEventArgs.Name
    $changeType = $Event.SourceEventArgs.ChangeType
    $timeStamp = $Event.TimeGenerated

    Write-Host "File $name was $changeType at $timeStamp" -ForegroundColor Cyan
    
    # Wait a bit to ensure file write is complete
    Start-Sleep -Seconds 2
    
    # Change to repo directory and push changes
    Set-Location $repoPath
    
    # Add all changes
    & git add .
    
    # Check if there are changes to commit
    $gitStatus = & git status --porcelain
    if ($gitStatus) {
        $commitMessage = "Auto-commit: $name changed at $timeStamp"
        & git commit -m $commitMessage
        & git push origin main
        Write-Host "Changes pushed to GitHub!" -ForegroundColor Green
    }
}

# Register the event
Register-ObjectEvent -InputObject $FileSystemWatcher -EventName "Changed" -Action $Action

Write-Host "File watcher is running. Press Ctrl+C to stop." -ForegroundColor Green

# Keep the script running
try {
    while ($true) {
        Start-Sleep -Seconds 1
    }
}
finally {
    $FileSystemWatcher.Dispose()
    Write-Host "File watcher stopped." -ForegroundColor Red
}

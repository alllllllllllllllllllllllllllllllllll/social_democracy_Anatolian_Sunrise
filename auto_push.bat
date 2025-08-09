@echo off
echo Auto-pushing changes to GitHub...
cd /d "C:\Users\Ege\social_democracy_Anatolian_Sunrise-2"

REM Add all changes
git add .

REM Check if there are any changes to commit
git diff-index --quiet HEAD --
if %ERRORLEVEL% EQU 0 (
    echo No changes to commit.
) else (
    REM Commit with timestamp
    for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
    for /f "tokens=1-3 delims=: " %%a in ('time /t') do (set mytime=%%a:%%b:%%c)
    git commit -m "Auto-commit: %mydate% %mytime%"
    
    REM Push to GitHub
    git push origin main
    echo Changes pushed successfully!
)

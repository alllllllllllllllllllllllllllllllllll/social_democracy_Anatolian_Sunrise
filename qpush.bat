@echo off
REM Quick push script - just run "qpush" from the repo directory
cd /d "C:\Users\Ege\social_democracy_Anatolian_Sunrise-2"
git add .
git commit -m "Quick update: %date% %time%"
git push origin main
echo Done!

#!/bin/bash
cd "C:\Users\Ege\Downloads\Social_Democracy\social_democracy_Anatolian_Sunrise"
export GIT_EDITOR="echo 'Merge changes' >"
git commit --no-edit
echo "Merge completed"
git log --oneline -3
echo "Now reverting the civil war removal..."
git revert HEAD~1 --no-edit
echo "Revert completed"
git push origin main
echo "Changes pushed to GitHub"

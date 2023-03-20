@echo off
git add .
echo adding files
set date=%date:~0,4%-%date:~5,2%-%date:~8,2%
git commit -m "%date% updated"
git push origin hexo
@pause
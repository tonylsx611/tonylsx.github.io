@echo off
git add .
set date=%date:~0,4%-%date:~5,2%-%date:~8,2%
echo Adding files...  Time: %date%
git commit -m "%date% updated"
git push origin hexo
echo Push to Github Successfully!
@pause
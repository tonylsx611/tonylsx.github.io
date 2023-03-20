@echo off
echo Deploying to https://tonylsx.top
hexo clean && hexo deploy && hexo g && hexo server
@pause
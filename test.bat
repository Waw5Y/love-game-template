@echo off
mkdir test\assets
xcopy /y /e /s source test
xcopy /y /e /s assets test\assets
lovec test
rmdir /s /q test
@echo off
mkdir build\x64\assets
mkdir build\x86\assets
bt\7za a -tzip build\x64\out.zip .\source\*
copy /b bt\x64\love.exe+build\x64\out.zip build\x64\game.exe
del /s /q build\x64\out.zip
xcopy /y bt\x64\*.dll build\x64
bt\7za a -tzip build\x86\out.zip .\source\*
copy /b bt\x86\love.exe+build\x86\out.zip build\x86\game.exe
del /s /q build\x86\out.zip
xcopy /y bt\x86\*.dll build\x86
xcopy /y /e /s assets build\x64\assets
xcopy /y /e /s assets build\x86\assets
build\x64\game --console
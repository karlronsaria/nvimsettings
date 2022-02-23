@echo off

set "powershell=%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\powershell.exe"
set "command=. %~dp0.\command.ps1"
set "command=%command%; Save-PlugInstallAppItem"

%powershell% -Command %command%
xcopy %~dp0..\share \tools\neovim\Neovim\ /s /e /y
xcopy %~dp0..\init.vim %LOCALAPPDATA%\nvim\ /s /e /y


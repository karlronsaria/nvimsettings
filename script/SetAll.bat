@echo off
xcopy %~dp0..\share \tools\neovim\Neovim\ /s /e /y
xcopy %~dp0..\init.vim %UserProfile%\AppData\Local\nvim\ /s /e /y


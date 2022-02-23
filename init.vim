" Enable syntax highlighting
syntax on

" Change tabs
set expandtab
set tabstop=4
set shiftwidth=4

" Automatically indent when starting new lines in code blocks
set autoindent

" Add line numbers
set number relativenumber

" Show column and line number in bottom right
set ruler

set nocompatible
filetype plugin on

call plug#begin()
    Plug 'sheerun/vim-polyglot'
    Plug 'vimwiki/vimwiki'
    " Plug 'dracula/vim' " , {'as': 'dracula'}
    Plug 'kristijanhusak/vim-simple-notifications'
    Plug 'powerline/powerline'
call plug#end()

" Show whitespace characters
set listchars=eol:¬,tab:>·,trail:·,extends:>,precedes:<,nbsp:.
set list

:function TestWorkingDirectory(function_name)
:  let l:current_file_path = expand('%:p')
:  if l:current_file_path == ""
:    echom a:function_name . ": Current file path not found"
:    return 0
:  endif
:  let l:systemroot = trim(system("echo %systemroot%"))
:  if stridx(l:current_file_path, l:systemroot) != ""
:    echom a:function_name . ": The editor working directory is "
       \ . l:current_file_path . "; the function cannot be called
       \ at this location"
:    return 0
:  endif
:  let l:cmd_wd = trim(system("cd"))
:  if stridx(l:cmd_wd, l:systemroot) > 0
:    echom a:function . ": The system working directory is "
       \ . l:cmd_wd . "; the function cannot be called
       \ at this location"
:    return 0
:  endif
:  return 1
:endfunction

" Requires: powershell cmdlet:Save-ClipboardToImageFormat
" Location: C:\devlib\powershell\Shortcut.ps1
:function SaveImage()
:  let l:fname = "SaveImage"
:  if !TestWorkingDirectory(l:fname)
:    return
:  endif
:  let l:pwsh_cmd =
     \ "Save-ClipboardToImageFormat
        \ -BasePath (Get-Location).Path
        \ -GetMarkdownString"
:  echo l:fname . ": Running PowerShell..."
:  echo trim(execute(":r ! powershell -Command \"" . l:pwsh_cmd . "\""))
:  call feedkeys("\<CR>o\<ESC>")
:endfunction

" Requires: powershell cmdlet:Move-ToTrashFolder
" Location: C:\devlib\powershell\Shortcut.ps1
:function RemoveImage()
:  let l:fname = "RemoveImage"
:  if !TestWorkingDirectory(l:fname)
:    return
:  endif
:  let l:pattern = '\v\(\zs\w*\/(\w+\/)+\d+(_\d+){3}\.\w+\ze\)'
:  let l:capture = matchstr(getline('.'), l:pattern)
:  let l:pwsh_cmd =
     \ "Move-ToTrashFolder -Path '" . l:capture . "' -TrashFolder '__OLD'"
:  if l:capture != ""
:    call feedkeys("dd")
:    echo l:fname . ": Running PowerShell..."
:    echo trim(execute("! powershell -Command \"" . l:pwsh_cmd . "\""))
:  else
:    echom l:fname . ": Pattern not found"
:  endif
:endfunction

:command Item :call feedkeys("/\\v^\\s*\\[\\zs.+\\ze\\]\<CR>")
:command Nonulls :call feedkeys(":%s/\\%x00//g\<CR>")
:command Img :call SaveImage()
:command Rimg :call RemoveImage()
:command Test :echom TestWorkingDirectory("Test")

:set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE

" colorscheme dracula


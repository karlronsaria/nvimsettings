function Save-PlugInstallAppItem {
    Param(
        [String]
        $Source = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    )

    $Destination = "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim"
    iwr -useb $Source | ni $Destination -Force
}

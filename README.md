# .files

![](./.media/image.png)

Personal dotfiles and general configuration files

## As for:

### `Neovim`

This version of my neovim init.vim uses both the [vim-plug](https://github.com/junegunn/vim-plug) plugin manager and [conqueror of completion](https://github.com/neoclide/coc.nvim) (*soon to be changed to the native lsp engine for performance reasons*), so be sure to have both of them set up before starting.

In the first run there will probably be a lot of red errors and panics exploding in your face. This is normal, you still haven't installed any plugin at all, so run:

```
:PlugInstall
```

And then reopen neovim. After that, you should change your `g:coc_node_path` to whatever the output of `where node` is (assuming you have node.js already installed).

My currently installed lsp servers are:

1. coc-json
2. coc-tsserver
3. coc-texlab
4. coc-r-slp
5. coc-pyright
6. coc-java
7. coc-go
8. ccls

### `Xournal++`

You probably want to have set up at least one toolbar configuration file before actually changing it to this one, to do so you can go to:

`View > Toolbars > Manage`

And add a custom one.

### `ST`

This is a heavily patched st distribution which implements the patches at `./st/patches`

### `dmenu`

I currently rely on dmenu for a lot of operations in my machines, I use it both as app launcher (j4-desktop-menu) and clipboard manager (clipmenu).

###### *currently a work in progress*

# CheckUpdate.nvim

checks if there's a new neovim version available on GitHub
## Install

* install with [lazy.nvim](https://github.com/folke/lazy.nvim)

```
    {
        "diegoroccia/checkupdate.nvim",
        init = function()
            require "checkupdate".init()
        end
    }
```

## TODO:
* remove dependency from curl (use socket.http?)
* add option for nightlies
* add option for git?

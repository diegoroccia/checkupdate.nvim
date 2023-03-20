# CheckUpdate.nvim

checks if there's a new neovim version available on GitHub
## Install

* install with [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
    {
        "diegoroccia/checkupdate.nvim",
        init = function()
            require "checkupdate".init()
        end
    }
```

## Configuration

```lua
{
    force_version = { -- only use for debugging
        major = 0,
        minor = 8,
        patch = 2
    },
    check_at_startup = false
}
```

## TODO:
* a lot
* a lot more

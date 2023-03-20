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

## Lualine integration example

```
sections = {
    lualine_x = {
        function ()
            if require"checkupdate".update_available then
                return "🚀"
            else
                return ""
            end
        end
    }

```

## TODO:
* remove dependency from curl (use socket.http?)
* add option for nightlies
* add option for git?

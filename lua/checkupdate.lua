local ok, notify = pcall(require, "notify")
if ok then
    vim.notify = notify
end

local M = {
    setup_called = false,
    update_available = false
}

M.config = M.setup

M.setup = function(config)
    local default_config = {
        check_at_startup = true,
    }

    M.setup = vim.tbl_deep_extend('force', default_config, config or {})

    M.setup_called = true
end

M.init = function()

    if not M.setup_called then
        M.setup()
    end

    vim.api.nvim_create_augroup("check_update", {
        clear = false
    })

    if M.setup.check_at_startup then
        vim.api.nvim_create_autocmd({ "VimEnter" }, {
            callback = function()
                M.check_update()
            end
        })
    end

    vim.api.nvim_create_user_command("CheckUpdate", function()
        M.check_update()
    end, {})
end

M.check_update = function()
    local Job = require 'plenary.job'

    if M.setup ~= nil then
        if M.setup.force_version then
            current_version = M.setup.force_version
        else
            current_version = vim.version()
        end
    else
        current_version = vim.version()
    end

    local check_version = function(tag)
        local major, minor, patch = string.match(tag, "v(%d+).(%d+).(%d+)")
        if (tonumber(major) < current_version.major) then
            return false
        elseif (tonumber(major) > current_version.major) then
            return true
        elseif (tonumber(minor) < current_version.minor) then
            return false
        elseif (tonumber(minor) > current_version.minor) then
            return true
        elseif (tonumber(patch) > current_version.patch) then
            return true
        else
            return false
        end
    end

    Job:new({
        command = 'curl',
        args = { "https://api.github.com/repos/neovim/neovim/releases" },
        on_exit = function(j)
            result = j:result()
            local ok, parsed = pcall(vim.json.decode, table.concat(result, ""))

            if not ok then
                vim.notify("Failed to parse")
                return
            end

            found = false
            for _, item in ipairs(parsed) do
                if (item.tag_name ~= "stable") and
                    (item.tag_name ~= "nightly") then
                    if check_version(item.tag_name) then
                        vim.defer_fn(function()
                            vim.notify("new version available!\n" .. item.tag_name .. "\n" .. item.html_url)
                        end, 100)
                        found = true
                    end
                end
            end
            M.update_available = found
        end,
    }):start()
end

_G.nvim_check_update = M.check_update

return M

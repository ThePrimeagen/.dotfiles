local keymaps = require("theprimeagen.keymap")
local nnoremap = keymaps.nnoremap
local vnoremap = keymaps.vnoremap
local Sources = require("twitchy.window.source")
local tmux = require("twitchy.window.tmux")
local window = require("twitchy.window")
local cargo = require("twitchy.window.cargo")
local tail = require("twitchy.window.tail")

local M = {
    window = false,
    twitch_source = nil,
    window_source = Sources.create_window_source()
}

local last_open_cat_tail
local last_known_dev_tty
local last_open_cargo_source

function cat_tail(path)
    if last_open_cat_tail then
        last_open_cat_tail:close()
    end

    last_open_cat_tail = tail.cat_tail(path)
    last_open_cat_tail:and_then(M.window_source)
    last_known_dev_tty = path
end

function M.twitch()

    if not M.twitch_source then
        M.twitch_source = tail.twitch("/tmp/twitch")
        M.twitch_source:stop()
        M.twitch_source:and_then(M.window_source)
    end

    return M.twitch_source
end

function redisplay_twitch()
    local twitch = M.twitch()

    -- forces twitch to rehydrate
    twitch:stop()
    twitch:start()
    twitch:replay()

    window.open()
end

function stop_cargo_and_tail()
    if last_open_cat_tail then
        last_open_cat_tail.on = false -- hack
    end
    if last_open_cargo_source then
        last_open_cargo_source:stop()
    end
end

function M.hide_all()
    M.twitch_source:stop()
end

function M.reset()
    if M.twitch_source then
        M.twitch_source:close()
    end
    if last_open_cat_tail then
        last_open_cat_tail:close()
    end
    if last_open_cargo_source then
        last_open_cargo_source:close()
    end

    M.twitch_source = nil
    last_open_cat_tail = nil
    last_open_cargo_source = nil
    last_known_dev_tty = nil
end

local silent = { silent = true }

function close_cargo_and_tail()
    if last_open_cat_tail then
        print("closing last cat tail")
        last_open_cat_tail:close()
        last_open_cat_tail = nil
    end
    if last_open_cargo_source then
        print("closing last cargo source")
        last_open_cargo_source:close()
        last_open_cargo_source = nil
    end
end

function ready_window_source()
    if M.twitch_source then
        M.twitch_source:stop()
    end

    M.window_source:start()
    window.open()
end

nnoremap("<leader>tt", function()
    if not is_open then
        return
    end

    if not last_open_cat_tail then
        redisplay_twitch()
    elseif not last_open_cat_tail.on then
        local twitch = M.twitch()
        twitch:stop()
        last_open_cat_tail:start()
    else
        local twitch = M.twitch()
        last_open_cat_tail:stop()
        redisplay_twitch()
    end
end, silent)

nnoremap("<leader>tc", function()
    stop_cargo_and_tail()
    redisplay_twitch()
end, silent)

nnoremap("<leader>ta", function()
    close_cargo_and_tail()
    ready_window_source()
    M.twitch():stop()

    if not tmux.has_session("cargo_arduino") then
        tmux.create_window("cargo_arduino")
    end

    tmux.send_kill("cargo_arduino")
    vim.defer_fn(function()
        tmux.send_clear("cargo_arduino")
        vim.defer_fn(function()

            last_open_cargo_source = cargo.arduino("cargo_arduino")

            last_open_cargo_source:and_then(
                Sources.AccumulatorSource:new()):and_then(M.window_source)

            print("awaiting for close")
            last_open_cargo_source:on_close(function(last_msg)
                print("close called")
                -- TODO: these are left open despite killing cargo run job
                tail.kill("ravedude")
                vim.defer_fn(function()
                    cat_tail(last_msg)
                end, 100)
            end)
        end, 100)
    end, 100)
end, silent)

nnoremap("<leader>tk", function()
    M.reset()
end, silent)

nnoremap("<leader>ts", function()
    M.twitch():stop()
    if last_open_cat_tail then
        last_open_cat_tail:start()
    end
end, silent)

nnoremap("<leader>twv", function()
    ready_window_source()
    M.window_source:start()
    window.reset()
    window.open()
end, silent)

nnoremap("<leader>twm", function()
    ready_window_source()
    M.window_source:stop()
    window.close()
end, silent)

nnoremap("<leader>te", function()
    if last_known_dev_tty then
        tail.append(last_known_dev_tty)
    end
end, silent)

vnoremap("<leader>te", function()
    if last_known_dev_tty then
        tail.append(last_known_dev_tty)
    end
end, silent)

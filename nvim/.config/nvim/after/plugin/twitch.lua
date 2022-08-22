local nnoremap = require("theprimeagen.keymap").nnoremap
local Sources = require("twitchy.window.source")
local tmux = require("twitchy.window.tmux")
local window = require("twitchy.window")
local cargo = require("twitchy.window.cargo")
local tail = require("twitchy.window.tail")

local M = {
    window = false,
    twitch_source = nil,
    tmux_source = nil,
}

M.window_source = Sources.AccumulatorSource:new()
M.window_source:and_then(Sources.create_window_source())
M.window_source:stop()

function cat_tail(path)
    if last_open_cargo_source then
        last_open_cargo_source:close()
    end

    last_open_cargo_source = tail.cat_tail(path)
    last_open_cargo_source:and_then(
        Sources.AccumulatorSource:new()):and_then(
        Sources.create_window_source())
end

function M.tmux(name)
    if not M.tmux_source and name then
        if not tmux.has_session(name) then
            tmux.create_window(name)
        end
        M.tmux_source = tmux.create_tail_source(name)
        M.tmux_source:stop()

        to_barrier(M.tmux_source):and_then(M.window_source)
    end

    return M.tmux_source
end

function M.twitch()
    if not M.twitch_source then
        M.twitch_source = tail.twitch("/tmp/twitch")
        M.twitch_source:stop()
        to_barrier(M.twitch_source):and_then(M.window_source)
    end

    return M.twitch_source
end

function M.hide_all()
    M.twitch_source:stop()
    M.tmux_source:stop()
end

function M.reset()
    if M.twitch_source then
        M.twitch_source:stop()
    end
    if M.tmux_source then
        M.tmux_source:stop()
    end

    M.twitch_source = nil
    M.tmux_source = nil
end

local silent = { silent = true }

function get_tmux_source(name)
    return M.tmux_source
end

function has_tmux_source(name)
    return M.tmux_source ~= nil
end

function ready_window_source()
    if M.twitch_source then
        M.twitch_source:stop()
    end
    if M.tmux_source then
        M.tmux_source:stop()
    end

    M.window_source:start()
end

function ready_tmux()
    if M.twitch_source then
        M.twitch_source:stop()
    end

    if not M.window then
        M.window = true
        window.open()
    end
end

function ready_twitch()
    if M.tmux_source then
        M.tmux_source:stop()
    end

    if not M.window then
        M.window = true
        window.open()
    end
end

nnoremap("<leader>tt", function()
    window.open()
end, silent)

nnoremap("<leader>tc", function()
    ready_twitch()
    local twitch = M.twitch()
    twitch:start()
end, silent)

local last_open_cargo_source
nnoremap("<leader>ta", function()
    if last_open_cargo_source then
        last_open_cargo_source:close()
    end

    ready_window_source()

    if not tmux.has_session("cargo_arduino") then
        tmux.create_window("cargo_arduino")
    end

    window.open()
    M.window_source:start()

    tmux.send_kill("cargo_arduino")

    vim.defer_fn(function()
        tmux.send_clear("cargo_arduino")
        vim.defer_fn(function()

            last_open_cargo_source = cargo.arduino("cargo_arduino")
            last_open_cargo_source:and_then(
                Sources.create_window_source()
            ):on_close(function(last_msg)
                last_open_cargo_source = nil
                tmux.send_kill("cargo_arduino")
                vim.defer_fn(function()
                    cat_tail(last_msg)
                end, 100)
            end)
        end, 100)
    end, 100)
end, silent)

nnoremap("<leader>twa", function()
    ready_window_source()
    window.close()
end)

nnoremap("<leader>tk", function()
    tmux.send_kill("cargo_arduino")
end, silent)

nnoremap("<leader>tr", function()
    -- TODO: Cargo run?
end, silent)

nnoremap("<leader>twv", function()
    ready_window_source()
    M.window_source:start()
    window.open()
end, silent)

nnoremap("<leader>twm", function()
    ready_window_source()
    M.window_source:stop()
    window.close()
end, silent)

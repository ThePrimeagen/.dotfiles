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

function M.tmux(name)

    if not M.tmux_source and name then
        if not tmux.has_session(name) then
            tmux.create_window(name)
        end
        M.tmux_source = tmux.create_tail_source(name)
    end

    return M.tmux_source
end

function M.twitch()
    print(M.twitch_source, "testing")
    if not M.twitch_source then
        print("twitch accumulate tail")
        M.twitch_source = tail.accumulate_tail("/tmp/twitch")
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

    tmux.reset()
    tail.reset()

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

nnoremap("<leader>tc", function()
    ready_twitch()
    local twitch = M.twitch()
    twitch:start()
end, silent)

nnoremap("<leader>ta", function()
    ready_tmux("cargo_arduino")

    local tmux = get_tmux_source("cargo_arduino")
    if not has_tmux_source("cargo_arduino") then
        tmux = M.tmux("cargo_arduino")
    end

    tmux:start()
end, silent)

nnoremap("<leader>tk", function()
    tmux.send_kill("cargo_arduino")
end, silent)

nnoremap("<leader>tr", function()
    cargo.cargo("cargo_arduino")
end, silent)

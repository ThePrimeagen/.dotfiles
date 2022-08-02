local function set_interval(callback, interval)
    local timer = vim.loop.new_timer()
    local function ontimeout()
        callback(timer)
    end
    vim.loop.timer_start(timer, interval, interval, ontimeout)
    return timer
end

local function clear_timeout(timer)
    vim.loop.timer_stop(timer)
    vim.loop.close(timer)
end

local last_highlighted = ""
local clear_interval = clear_timeout
local i

local M = {}
function M.InsertMeDaddy(interval, text)
    interval = interval or 200
    text = text or last_highlighted

    local pos = 1

    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    print("setting text", text, "starting at row", row)

    i = set_interval(function()
        vim.schedule(function()
            if pos > #text then
                clear_interval(i)
                i = nil
                return
            end

            local char = string.sub(text, pos, pos)

            if char == "\n" then
                row = row + 1
                pos = pos + 1
                print("adjusting line to", row)
                return
            end

            local line = unpack(vim.api.nvim_buf_get_lines(0, row - 1, row, false))

            print("got line", line, "putting char", char, "at", row)
            if not line or line == "" then
                line = ""
            end
            print("line finished", line)

            line = line .. char
            vim.api.nvim_buf_set_lines(0, row - 1, row, false, {line})

            pos = pos + 1
        end)
    end, interval);
end

function M.StopMeDaddy()
    if i ~= nil then
        clear_interval(i)
    end
end

function M.SetFromHighlight()
    local _, s_row, _, _ = unpack(vim.fn.getpos("'<"))
    local _, e_row, _, _ = unpack(vim.fn.getpos("'>"))

    last_highlighted = table.concat(
        vim.api.nvim_buf_get_lines(0, s_row - 1, e_row, false),
        "\n"
    )
end

return M

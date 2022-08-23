local VimWithMe = require("vim-with-me")
local function hello()
    local status = VimWithMe.StatusVimWithMe()
    if status == VimWithMe.ClientStopped then
        return status
    end

    local point_count, point_expected = VimWithMe.get_points()
    return string.format("%d / %d", point_count, point_expected)
end

local sections = { lualine_a = { hello } }

require('lualine').setup({
    sections = sections,
})



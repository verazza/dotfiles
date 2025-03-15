local notify = require("notify")

-- vim.api.nvim_set_hl(0, "NotifyBackground", { link = "NormalFloat" })

vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "#000000" }) -- または "#000000"

notify.setup({
    background_colour = "#000000",
    -- render = "minimal",
    stages = "fade_in_slide_out",
    position = "bottom-right",
    timeout = 3000,
    animation_speed = 100,
    border = "rounded",

    -- ログレベル (debug, info, warn, error)
    -- level = "info",
    icons = {
        ERROR = "",
        WARN = "",
        INFO = "",
        DEBUG = "",
        TRACE = "✎",
    },
    top_down = false,
})

vim.notify = notify

require('telescope').load_extension('notify')


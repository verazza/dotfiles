return {
  "Shatur/neovim-session-manager",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("session_manager").setup {
      -- 設定オプション (必要に応じて変更)
    }
  end,
}

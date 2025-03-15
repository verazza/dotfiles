return {
  "scalameta/nvim-metals",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "scala", "sbt", "java" },
  opts = require("settings.lsp.metals").opts, -- opts関数を読み込む
  config = function(self, metals_config)
    -- 以下、javaファイルを開いた際にnvim-javaと競合しないために必要
    local current_dir = vim.fn.expand("%:p:h")
    local scala_files = vim.fn.glob(current_dir .. "/**/*.scala", true, true)

    if #scala_files == 0 then
      -- .scalaファイルが存在しない場合、metalsを起動しない
      return
    end

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = self.ft,
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}

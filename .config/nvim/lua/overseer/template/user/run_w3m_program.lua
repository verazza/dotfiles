return {
  name = "Run W3m Program",
  builder = function()
    -- ユーザーに入力を促す
    local search_query = vim.fn.input("検索クエリを入力: ")
    local term_size = math.floor(vim.o.columns / 2)

    return {
      cmd = { "bash", "-c", "search " .. search_query },
      components = { "default" },
    -- see https://github.com/stevearc/overseer.nvim/blob/master/doc/strategies.md#terminal
      strategy = {
        "toggleterm",
        direction = "vertical",
        size = term_size,
        hidden = true,
      },
    }
  end,
}

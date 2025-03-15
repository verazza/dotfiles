return {
  name = "Run C++ Program",
  builder = function()
    local filename = vim.fn.expand("%:t:r") -- ファイル名（拡張子なし）
    local filepath = vim.fn.expand("%:p")   -- フルパス
    local cwd = vim.fn.getcwd()           -- 現在のディレクトリ
    local relative_path = vim.fn.fnamemodify(filepath, ":~:.") -- 相対パス

    -- .gitディレクトリが存在するか確認
    if vim.fn.isdirectory(vim.fn.finddir(".git", cwd .. ";")) == 1 then
      -- distディレクトリへの相対パスを生成
      local dist_path = vim.fn.join({ cwd, "dist", relative_path }, "/")
      dist_path = vim.fn.fnamemodify(dist_path, ":h") -- ファイル名を除外してディレクトリパスを取得

      -- distディレクトリが存在しなければ作成
      if vim.fn.isdirectory(dist_path) == 0 then
        vim.fn.mkdir(dist_path, "p")
      end

      local output = vim.fn.join({ dist_path, filename }, "/") -- 出力ファイルパス
      -- local term_size = math.floor(vim.o.lines / 4)

      return {
        cmd = { "bash", "-c", string.format("g++ -o %s %s && %s", output, filepath, output) },
        components = { "on_exit_set_status" },
        strategy = {
          "toggleterm",
          direction = "float",
          hidden = true,
          -- size = term_size,
        },
      }
    else
        local output = vim.fn.expand("%:p:r")
        return {
          cmd = { "bash", "-c", string.format("g++ -o %s %s && %s", output, filepath, output) },
          components = { "on_exit_set_status" },
          strategy = {
            "toggleterm",
            direction = "horizontal",
            hidden = true,
            -- size = term_size,
          },
        }
    end
  end,
}

return {
  name = "Run Scala Program (Auto)",
  builder = function()
    local filename = vim.fn.expand("%:t:r") -- ファイル名（拡張子なし）
    local filepath = vim.fn.expand("%:p")    -- フルパス
    local cwd = vim.fn.getcwd()             -- 現在のディレクトリ

    -- .gitフォルダまでのパスを取得
    local project_root = filepath
    while project_root ~= "/" do
      if vim.fn.isdirectory(project_root .. "/.git") == 1 then
        break
      end
      project_root = vim.fn.fnamemodify(project_root, ":h")
    end

    if project_root == "/" then
      return {
        cmd = { "sbt", "run" }, -- デフォルトのrunタスク
        components = { "on_exit_set_status" },
        strategy = {
          "toggleterm",
          direction = "float",
          hidden = true,
        },
      }
    end

    -- srcディレクトリまでのパスを取得
    local src_path = filepath
    while src_path ~= project_root do
      if src_path:match("/src$") then
        break
      end
      src_path = vim.fn.fnamemodify(src_path, ":h")
    end

    -- ベース名の取得
    local basename = vim.fn.fnamemodify(src_path, ":h:t")

    -- プロジェクトスコープを設定
    local scope = basename == "" and "" or (src_path == project_root .. "/src" and "" or basename)

    -- パッケージ名を取得
    local file_content = vim.fn.readfile(filepath)
    local package_name = ""
    for _, line in ipairs(file_content) do
      local match = line:match("package%s+(%w+%.?%w*)")
      if match then
        package_name = match
        break
      end
    end

    if package_name == "" then
        vim.notify("パッケージ宣言のないファイルは実行できません。", vim.log.levels.ERROR)
        return
    end

    -- 完全修飾クラス名を生成
    local full_class_name = package_name .. "." .. filename

    -- ディレクトリ移動とrunMainタスクの実行
    local cmd = "cd " .. src_path .. "/.." .. " && sbt '" .. (scope == "" and "runMain " .. full_class_name or scope .. "/runMain " .. full_class_name) .. "'"

    -- デバッグ情報を表示
    print("src_path: " .. src_path)
    print("scope: " .. scope)
    print("cmd: " .. cmd)

    return {
      cmd = cmd,
      components = { "on_exit_set_status" },
      strategy = {
        "toggleterm",
        direction = "float",
        hidden = true,
      },
      on_exit = function(task, exit_code, stdout, stderr)
        -- タスクの終了コードと出力をターミナルに表示
        vim.api.nvim_echo({ { "Exit code: " .. tostring(exit_code), "Normal" } }, true, {})
        if stdout then
          vim.api.nvim_echo({ { "Stdout: " .. stdout, "Normal" } }, true, {})
        end
        if stderr then
          vim.api.nvim_echo({ { "Stderr: " .. stderr, "Error" } }, true, {})
        end

        -- 元のディレクトリに戻る
        vim.fn.chdir(cwd)
      end,
    }
  end,
}

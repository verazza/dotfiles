return {
  name = "Run Scala Program (DAP)",
  builder = function()
    local filename = vim.fn.expand("%:t:r") -- ファイル名（拡張子なし）
    local filepath = vim.fn.expand("%:p")    -- フルパス
    local cwd = vim.fn.getcwd()             -- 現在のディレクトリ
    local relative_path = vim.fn.fnamemodify(filepath, ":~:.") -- 相対パス
    local build_sbt_path = vim.fn.findfile("build.sbt", cwd .. ";") -- build.sbtのパス

    if not build_sbt_path or build_sbt_path == "" then
      return {
        cmd = { "sbt", "run" },
        components = { "on_exit_set_status" },
        strategy = {
          "toggleterm",
          direction = "float",
          hidden = true,
        },
      }
    else
      local project_dir = vim.fn.fnamemodify(build_sbt_path, ":h") -- build.sbtのディレクトリ
      return {
        cmd = { "sbt", "run" },
        components = { "on_exit_set_status" },
        strategy = {
          "toggleterm",
          direction = "float",
          hidden = true,
        },
        cwd = project_dir,
        on_ready = function(task)
          local dap = require("dap")
          local dapui = require("dapui")

          -- デバッグ設定を選択
          dap.configurations.scala = {
            {
              type = "scala",
              request = "launch",
              name = "RunOrTest",
              mainClass = filename,
              cwd = project_dir,
            },
          }

          dap.listeners.on("terminated", function(event)
            -- デバッグ実行の結果を取得
            local result = event.body.exitCode

            -- 結果をターミナルに表示
            vim.api.nvim_echo({ { "Exit code: " .. tostring(result), "Normal" } }, true, {})

            -- dapuiを閉じる
            dapui.close()

            -- タスクを終了
            task:close()
          end)

          -- デバッグ実行を開始
          dap.run("scala")
        end,
      }
    end
  end,
}

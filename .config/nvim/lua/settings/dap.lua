local dap, dapui = require("dap"), require("dapui")
local install_root_dir = vim.fn.stdpath("data") .. "/mason"
local extension_path = install_root_dir .. "/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"

dap.adapters.java = function(callback)
    -- Java Debug Server のポートを指定
    callback({
        type = 'server',
        host = '127.0.0.1',
        port = 5005
    })
end

local fmc_classpaths = {
    "/home/bella/git/FMC/common/build/classes/java/main",
    "/home/bella/git/FMC/fabric/favcore/build/classes/java/main",
    "/home/bella/git/FMC/forge/fovcore/build/classes/java/main",
    "/home/bella/git/FMC/neoforge/neofovcore/build/classes/java/main",
    "/home/bella/git/FMC/spigot/svcore/build/classes/java/main",
    "/home/bella/git/FMC/velocity/build/classes/java/main",
}

dap.configurations.java = {
    {
        name = '[FMC] Java: Debug Current File: Launch',
        type = 'java',
        request = 'launch',
        mainClass = '${file}',
        projectName = "FMC",
        classPaths = fmc_classpaths,
    },
    {
        name = '[FMC] Java: Debug Current File: Attach',
        type = 'java',
        request = 'attach',
        mainClass = '${file}',
        projectName = "FMC",
        classPaths = fmc_classpaths,
    },
}

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = codelldb_path,
        args = { "--port", "${port}" },
    },
}

dap.configurations.c = {
    {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.input("実行可能ファイルのパス: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
    },
}

dap.configurations.cpp = dap.configurations.c

dap.configurations.scala = {
    {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = {
            runType = "runOrTestFile",
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
        },
    },
    {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
            runType = "testTarget",
        },
    },
}

-- open_on_attach = true,
-- open_on_launch = true,

dapui.setup({})

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
-- dap.listeners.before.event_terminated.dapui_config = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
--     dapui.close()
-- end


local dap_install = require("dap-install")
dap_install.config("chrome", {})


local dap = require("dap");
dap.configurations.typescriptreact = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

require('dap.ext.vscode').load_launchjs()

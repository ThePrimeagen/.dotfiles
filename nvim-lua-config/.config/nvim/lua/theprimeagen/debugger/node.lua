local home = os.getenv('HOME')
local dap = require('dap')
dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {home .. '/personal/microsoft-sucks/vscode-node-debug2/out/src/nodeDebug.js'},
}

dap.configurations.javascript = {
    {
        name = 'Launch',
        type = 'node2',
        request = 'launch',
        program = '${file}',
        cwd = vim.loop.cwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal',
    },
    {
        -- For this to work you need to make sure the node process
        -- is started with the `--inspect` flag.
        name = 'Attach to process',
        type = 'node2',
        request = 'attach',
        processId = require('dap.utils').pick_process,
    },
}


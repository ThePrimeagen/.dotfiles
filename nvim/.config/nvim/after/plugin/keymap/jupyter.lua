local Remap = require("theprimeagen.keymap")
local nmap = Remap.nmap

nmap("<leader><leader>x", "<Plug>JupyterExecute")
nmap("nmap <leader><leader>X", "<Plug>JupyterExecuteAll")


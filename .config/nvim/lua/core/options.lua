vim.cmd("autocmd!")

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.clipboard:append { 'unnamedplus' }
vim.g.mapleader = " "
vim.opt.timeoutlen = 300 -- キーマップの待ち時間
vim.wo.number = true
vim.opt.laststatus = 2 --Status Line
vim.opt.confirm = true
vim.opt.tabstop = 2 -- tab setting
vim.opt.shiftwidth = 2 -- tab setting
vim.opt.expandtab = true -- インデントはtabでなくスペースにする
vim.opt.autoindent = true -- indent
vim.opt.smartindent = true -- indent
vim.opt.termguicolors = true -- true color
vim.opt.foldmethod = 'indent' -- 折りたたみ
vim.opt.foldlevel = 99 -- 折りたたみの最大レベル
-- whitespaceをハイライトする
vim.cmd[[
  hi DoubleByteSpace term=underline ctermbg=blue guibg=darkgray
  match DoubleByteSpace /　/
]]

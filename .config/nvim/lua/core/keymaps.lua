local keymap = vim.keymap
-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

if not vim.g.vscode then
  vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
  keymap.set("i", "<Leader>j", "<Esc>", { noremap = true, silent = true })

  keymap.set('n', '<Leader>w', ':w<CR>') -- ファイル保存
  keymap.set('n', '<Leader>q', ':q<CR>') -- ファイル閉じる

  -- delete
  keymap.set('n', 'x', '"_x')
  keymap.set('n', '<S-t>', ':tabedit<CR>')
  -- Split window
  keymap.set('n', 'ss', ':split<CR><C-w>w')
  keymap.set('n', 'vs', ':vsplit<CR><C-w>w')
  keymap.set('n', '<S-q>', ':q<CR><C-w>w')
  -- Move window
  keymap.set('n', '<Tab>', '<C-w>w') -- Tabで次のウィンドウに移動
  keymap.set('', '<leader>h', '<C-w>h') -- 下に移動
  keymap.set('', '<leader>i', '<C-w>k') -- 下に移動
  keymap.set('', '<leader>j', '<C-w>j') -- 上に移動
  keymap.set('', '<leader>l', '<C-w>l') -- 左に移動
  -- 折りたたみ
  keymap.set("n", "<Leader>;", "za", { noremap = true, silent = true }) -- 折りたたみトグル
  -- go test
  keymap.set('c', 'GT', ':!go test -v -race -cover ./...<CR>')
  -- buffer
  keymap.set("n", "\\", ":e #<CR>", { silent = true })
  -- plugins
  -- telescope
  keymap.set('n', ';f', ':Telescope find_files<CR>')
  keymap.set('n', ';g', ':Telescope egrepify<CR>')
  -- neo-tree
  keymap.set('n', '<C-f>', '<cmd>Neotree toggle<CR>', { noremap = true, silent = true })
  keymap.set('v', '<C-f>', '<cmd>Neotree toggle<CR>', { noremap = true, silent = true })
  -- bufferline
  keymap.set('n', 'H', ':BufferLineCyclePrev<CR>')
  keymap.set('n', 'L', ':BufferLineCycleNext<CR>')
  vim.api.nvim_set_keymap('n', 'W', ':bdelete<CR>', { noremap = true, silent = true })
else
  -- vscode
end

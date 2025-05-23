-- Troca do nomo INSERT para NORMAL jk
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'Troca par ao modo normal' })
-- Troca do modo INSERT para NORMAL a partir do TERMINAL jk
vim.keymap.set('t', 'jj', [[<C-\><C-n>]], { desc = 'Troca do modo INSERT para NORMAL a partir do TERMINAL jk' })
-- Insere linha abaixo sem entrar no modo insert
vim.keymap.set('n', '<leader>o', ":put =''<CR>", { desc = 'Insere linha abaixo sem entrar no modo insert' })
-- Insere linha acima sem entrar no modo insert
vim.keymap.set('n', '<leader>O', ":put ='' | move -2<CR>k", { desc = 'Insere linha abaixo sem entrar no modo insert' })

-- Toggle de terminal (abre se não estiver aberto, fecha se já estiver)
vim.keymap.set('n', '<leader>tt', function()
  -- Verifica se existe algum terminal aberto
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == 'terminal' then
      -- Fecha o terminal
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  -- Caso não tenha terminal, abre um split + terminal e entra em insert mode
  vim.cmd 'split'
  vim.cmd 'terminal'
  vim.cmd 'startinsert' -- Aqui o `startinsert` é um comando do Neovim, então não precisa do `|`
end, { desc = 'Toggle terminal in horizontal split' })

vim.keymap.set('v', '<leader>u', function()
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local len = #line

  -- Inicia a seleção sem sair do modo visual
  vim.api.nvim_feedkeys('v', 'n', false)

  -- Movimenta o cursor até a posição desejada
  while col < len do
    col = col + 1
    local char = line:sub(col + 1, col + 1)
    if char:match '%u' or char == ' ' then
      col = col - 1
      break
    end
  end

  -- Atualiza a posição do cursor para a seleção
  vim.api.nvim_win_set_cursor(0, { row, col })

  -- Mantém o modo visual e a seleção ativa
  vim.api.nvim_feedkeys('gv', 'n', false)
end, { noremap = true, silent = true, desc = 'Seleciona até antes do próximo uppercase ou espaço' })

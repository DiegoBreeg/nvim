-- Ativa o número absoluto em todas as linhas
vim.opt.number = true
-- Desativa o número relativo
vim.opt.relativenumber = false

-- Exibe o número absoluto em todas as linhas
-- O número relativo será calculado manualmente com base no movimento do cursor
vim.opt.statuscolumn = "%l %{abs(v:lnum - line('.'))} "

-- Customiza a exibição de números relativos manualmente para as outras linhas
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function()
    -- Atualiza a linha de status (relative line) corretamente quando o cursor se move
    vim.opt.statuscolumn = "%l %{abs(v:lnum - line('.'))} "
  end,
})

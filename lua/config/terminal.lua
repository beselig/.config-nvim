-- Terminal Specific
vim.api.nvim_create_autocmd("TermOpen", {
  desc = 'vim options for when in terminal mode',
  group = vim.api.nvim_create_augroup('custom-terminal-options', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

-- local job_id = 0
vim.keymap.set('n', "<leader>st", function()
  local win = vim.api.nvim_get_current_win()
  local win_width, win_heigth =
      vim.api.nvim_win_get_width(win),
      vim.api.nvim_win_get_height(win)

  vim.api.nvim_open_win(
    vim.api.nvim_get_current_buf(),
    true,
    {
      relative = "editor",
      row = 2,
      col = 4,
      width = win_width - 8,
      height = win_heigth - 4
    })
  vim.cmd.term()

  -- vim.cmd.vnew()
  -- vim.cmd.term()
  -- vim.cmd.wincmd('J')
  -- vim.api.nvim_win_set_height(0, 15)
  -- job_id = vim.bo.channel
end)

-- vim.keymap.set('n', "<space>example", function()
-- --make
-- --go build
-- --test /this/thing/here
--   if job_id then
--     vim.fn.chansend(job_id, { "echo 'hi'\r\n" })
--   end
-- end)

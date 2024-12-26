local M = {}

local function get_npm_root()
  local volta_version = vim.fn.system('volta --version 2>/dev/null')
  local npm_root = ''

  if volta_version == "" then
    npm_root = vim.fn.system('npm root -g'):gsub('\n', '')
  else
    npm_root = vim.fn.expand("$HOME") .. '/.volta/tools/image/packages'
  end

  return npm_root
end

M.get_npm_root = get_npm_root

return M

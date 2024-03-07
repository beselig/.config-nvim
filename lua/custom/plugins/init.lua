-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'github/copilot.vim',
    opts = {
      g = {
        copilot_node_version = 20,
        copilot_workspace_folders = { '~/projects/wurzelkind' },
        -- don't use <Tab> for completion
      },
    },
  },
}

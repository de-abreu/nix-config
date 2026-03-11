-- Allow to search for a filename or string contained in a file, as seen
-- with yazi.
local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, _)
      local actions = require "telescope.actions"
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require "telescope.actions.state"
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- Navigate to the selected file in Neo-tree
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  optional = true,
  opts = {
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()

        -- 1. Check if the node is a directory
        if node.type ~= "directory" then
          -- Optional: Notify the user why nothing happened
          vim.notify("Please select a directory to search", vim.log.levels.INFO)
          return
        end

        local path = node:get_id()
        require("telescope.builtin").find_files(getTelescopeOpts(state, path))
      end,

      telescope_grep = function(state)
        local node = state.tree:get_node()

        -- 1. Check if the node is a directory
        if node.type ~= "directory" then
          vim.notify("Please select a directory to grep", vim.log.levels.INFO)
          return
        end

        local path = node:get_id()
        require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
      end,
    },
    filesystem = {
      window = {
        mappings = {
          ["s"] = "telescope_find",
          ["S"] = "telescope_grep",
        },
      },
    },
  },
}

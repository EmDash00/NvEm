local inputs = require("neo-tree.ui.inputs")

local util = {}

-- Trash the target
function util.trash(state)
  local node = state.tree:get_node()
  if node.type == "message" then
    return
  end
  local _, name = require("neo-tree.utils").split_path(node.path)
  vim.api.nvim_command("silent !gtrash put " .. node.path)
  require("neo-tree.sources.manager").refresh(state)
end

-- Trash the selections (visual mode)
function util.trash_visual(state, selected_nodes)
  local paths_to_trash = {}
  for _, node in ipairs(selected_nodes) do
    if node.type ~= "message" then
      table.insert(paths_to_trash, node.path)
    end
  end
  local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
  inputs.confirm(msg, function(confirmed)
    if not confirmed then
      return
    end
    for _, path in ipairs(paths_to_trash) do
      vim.api.nvim_command("silent !gtrash put " .. path)
    end
    require("neo-tree.sources.manager").refresh(state)
  end)
end

-- Open selection in file explorer.
function util.sys_open(state)
  local node = state.tree:get_node()
  local path = node:get_id()
  -- macOs: open file in default application in the background.
  vim.fn.jobstart({ "xdg-open", "-g", path }, { detach = true })
  -- Linux: open file in default application
  vim.fn.jobstart({ "xdg-open", path }, { detach = true })

  -- Windows: Without removing the file from the path, it opens in code.exe instead of explorer.exe
  local p
  local lastSlashIndex = path:match("^.+()\\[^\\]*$")     -- Match the last slash and everything before it
  if lastSlashIndex then
    p = path:sub(1, lastSlashIndex - 1)                   -- Extract substring before the last slash
  else
    p = path                                              -- If no slash found, return original path
  end
  vim.cmd("silent !start explorer " .. p)
end

function util.get_telescope_opts(state, path)
      return {
        cwd = path,
        search_dirs = { path },
        attach_mappings = function(prompt_bufnr, map)
          local actions = require "telescope.actions"
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local action_state = require "telescope.actions.state"
            local selection = action_state.get_selected_entry()
            local filename = selection.filename
            if (filename == nil) then
              filename = selection[1]
            end
            -- any way to open the file without triggering auto-close event of neo-tree?
            require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
          end)
          return true
        end
      }
    end

return util

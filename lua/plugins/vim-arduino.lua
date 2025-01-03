return {
  "vim-arduino",
  ft = { "c", "cpp", "arduino" },
  before = function()
    --require("lz.n").trigger_load({"telescope.nvim", "vimp"})

    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local pickers = require('telescope.pickers')
    local finders = require('telescope.finders')
    local conf = require('telescope.config').values
    local vimp = require('vimp')

    local nnoremap = vimp.nnoremap


    -- Define your list of actions and commands
    local actions_list = {
      { name = "Attach Arduino",                  command = "ArduinoAttach" },
      { name = "Choose Board",                    command = "ArduinoChooseBoard" },
      { name = "Choose Programmer",               command = "ArduinoChooseProgrammer" },
      { name = "Choose Port",                     command = "ArduinoChoosePort" },
      { name = "Verify",                          command = "ArduinoVerify" },
      { name = "Upload",                          command = "ArduinoUpload" },
      { name = "Serial Monitor",                  command = "ArduinoSerial" },
      { name = "Upload and Start Serial Monitor", command = "ArduinoUploadAndSerial" },
      { name = "Info",                            command = "ArduinoInfo" },
    }

    -- Function to execute the command on selection
    local function run_selected_command(prompt_bufnr)
      local selected = action_state.get_selected_entry()
      actions.close(prompt_bufnr)   -- Close the Telescope prompt

      -- Execute the selected command
      vim.cmd(selected.command)
    end

    -- Create the Telescope picker
    local function action_picker()
      pickers.new({}, {
        prompt_title = "Arduino Vim",
        finder = finders.new_table {
          results = actions_list,
          entry_maker = function(entry)
            return {
              value = entry.command,
              display = entry.name,
              ordinal = entry.name,
              command = entry.command,
            }
          end
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(_, map)
          map('i', '<CR>', run_selected_command)   -- Map Enter in insert mode
          map('n', '<CR>', run_selected_command)   -- Map Enter in normal mode
          return true
        end
      }):find()
    end

    -- Bind the picker to a key

    nnoremap({ 'silent' }, '<C-a>', action_picker)
    nnoremap({ 'silent' }, '<leader>t', function() print("test") end)
  end
}

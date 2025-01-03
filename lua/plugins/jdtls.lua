return {
  "jdtls",
  ft = { "java" },
  after = function()
  local function patch_gradle_loading_times()
      local project_dir_markers = { 'build.gradle.kts' }
      local root_dir = vim.fs.root(0, project_dir_markers)

      -- CAREFUL, this might be intense on big projects
      -- find in root_dir
      local subprojects = vim.fs.find(project_dir_markers,
          { upward = false, type = "file", limit = math.huge, path = root_dir })

      local count = 0
      -- For Gradle only lets remove the .settings folder
      for i, subproject in ipairs(subprojects) do
          local project_dir = vim.fs.dirname(subproject)

          local f = io.open(project_dir .. "/build.gradle.kts", "r")
          if f ~= nil then
              io.close(f)
              -- Set the Java test runner
              vim.api.nvim_exec2([[
                  let test#java#runner = 'gradletest'
              ]], { output = true })

              -- Check if the .settings folder exists before removing it
              local settings_dir = project_dir .. "/.settings"
              if vim.fn.isdirectory(settings_dir) == 1 then
                  os.execute("gtrash put " .. settings_dir)
                  count = count + 1
              end
          end
      end
      print("jdtls patching: removed " .. count .. " gradle settings")
    end

    require('jdtls').start_or_attach {
        cmd = {'jdtls'},
        root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
        before_init = patch_gradle_loading_times
    }
  end
}

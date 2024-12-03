-- Collection of various small independent plugins/modules
return {
  {
    "echasnovski/mini.nvim",
    event = "VimEnter",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup({ n_lines = 500, search_method = "cover" })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Start screen
      --
      -- Shows recent files to pick from as well as quick actions
      local starter = require("mini.starter")
      local logo = table.concat({
        [[░▒▓████████▓▒░]],
        [[░▒▓█▓▒░       ]],
        [[░▒▓█▓▒░       ]],
        [[░▒▓██████▓▒░  ]],
        [[░▒▓█▓▒░       ]],
        [[░▒▓█▓▒░       ]],
        [[░▒▓████████▓▒░]],
      }, "\n")
      local pad = string.rep("", 14)
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end
      starter.setup({
        autoopen = true,
        header = logo,
        evaluate_single = true,
        items = {
          new_section("Find file", "Telescope frecency workspace=CWD hidden=true", "Telescope"),
          new_section("New file", "ene | startinsert", "Built-in"),
          new_section("Recent files", "Telescope oldfiles hidden=true only_cwd=true", "Telescope"),
          new_section("Lazy", "Lazy", "Lazy"),
          new_section("Quit", "qa", "Built-in"),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", false),
          starter.gen_hook.aligning("center", "center"),
        },
      })
      -- Set starter footer and refresh after `startuptime` is available
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function(ev)
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = string.rep("", 8)
          starter.config.footer = pad_footer
            .. "⚡ Loaded plugins: "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. "\n"
            .. pad_footer
            .. "⚡ Startup time: "
            .. ms
            .. " ms"
          if vim.bo[ev.buf].filetype == "ministarter" then
            pcall(starter.refresh)
          end
        end,
      })

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}

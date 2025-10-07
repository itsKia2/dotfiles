return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },

    defer = {
      gc = "Comments",
    },

    -- replaces `key_labels`
    replace = {
      -- ["<space>"] = "SPC",
      -- ["<cr>"] = "RET",
      -- ["<tab>"] = "TAB",
    },

    keys = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },

    win = {
      border = "single",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 2, 2, 2, 2 },
      winblend = 0,
    },

    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "left",
    },

    filter = function()
      return true
    end,

    defer_patterns = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

    show_help = true,
    show_keys = true,

    triggers = { "<leader>" },

    blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    },

    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  },
}

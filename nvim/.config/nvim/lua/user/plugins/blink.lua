return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "v0.*",
  opts = {
    keymap = {
      preset = "default",
      ["<C-d>"] = { "snippet_forward", "fallback" },
      ["<C-D>"] = { "snippet_backward", "fallback" },
      ["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
      ["<CR>"] = { "accept", "fallback" },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      -- optionally disable cmdline completions
      cmdline = {},
    },

    completion = {
      menu = {
        auto_show = false,
      },
      ghost_text = {
        enabled = false,
      },
      documentation = {
        auto_show = false,
      },
    },

    signature = {
      enabled = false,
    },
  },

  opts_extend = { "sources.default" },
}

return {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  enabled = vim.env.OBSIDIAN_VAULT_PATH ~= nil and vim.env.OBSIDIAN_VAULT_PATH ~= "",
  config = function()
    local vault_path = vim.env.OBSIDIAN_VAULT_PATH
    if not vault_path or vault_path == "" then
      vim.notify("[Obsidian.nvim] OBSIDIAN_VAULT_PATH not set. Plugin disabled.", vim.log.levels.WARN)
      return
    end

    require("obsidian").setup({
      workspaces = {
        {
          name = "vault",
          path = vault_path,
        },
      },
      completion = {
        nvim_cmp = false,
        min_chars = 2,
      },
      note_frontmatter_func = function(note)
        if note.title then
          note:add_alias(note.title)
        end

        local out = {
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
          area = "",
          project = "",
        }

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
      notes_subdir = "0. Inbox",
      mappings = {
        ["<leader>of"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>oc"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },
    })

    vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Obsidian new note" })
    vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Obsidian open note" })
  end,
}

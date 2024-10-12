return -- lazy.nvim
{
  "robitx/gp.nvim",
  config = function()
    local conf = {
      agents = {
        {
          name = "ChatGPT3-5",
          disable = true,
        },
        {
          name = "MyCustomAgent",
          provider = "copilot",
          chat = true,
          command = true,
          model = { model = "gpt-4-turbo" },
          system_prompt = "Answer any query with just: Sure thing..",
        },
      },
      providers = {
        openai = {
          disable = true,
        },
        copilot = {
          disable = false,
        },
      },
    }

    require("gp").setup(conf)

    -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
  end,
}

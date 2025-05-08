return {
  "projekt0n/github-nvim-theme",
  priority = 1000,
  config = function()
    require("github-theme").setup({
      options = {
        transparent = false,
        modules = {
          neotree = true,
        },
        styles = {
          comments = "italic",
          keywords = "bold",
          functions = "bold",
          variables = "NONE"
        },
      },
    })
    vim.cmd("colorscheme github_dark_default")
  end
}

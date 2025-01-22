return {
  {
    "nvim-orgmode/orgmode",
    dependencies = {
      "akinsho/org-bullets.nvim",
    },
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/orgmode/*",
        org_default_notes_file = "~/orgmode/index.org",
        org_archive_location = "~/orgmode/archive.org",

        org_todo_keywords = { "TODO(t)", "DOING(i)", "REVIEW(r)", "|", "DONE(d)" },
        org_todo_keyword_faces = {
          TODO = ":foreground #6d96a5 :weight bold",
          DOING = ":foreground #b29e75 :weight bold",
          REVIEW = ":foreground #8c738c :weight bold",
          DONE = ":foreground #809575 :weight bold",
        },

        org_capture_templates = {
          w = {
            description = "Work Task",
            template = "* TODO %?\n[[][Github Link]]",
            target = "~/orgmode/work.org",
          },
        },
      })

      require("org-bullets").setup()
    end,
  },
}

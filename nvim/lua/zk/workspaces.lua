local M = {}

M.workspaces = {
  index = {
    name = "index",
    path = { index = "~/Documents/vault/000-Index" },
    template = "index.md",
  },
  fleeting = {
    name = "fleeting",
    path = {
      fleeting = "~/Documents/vault/001-Fleeting",
      pseudocode = "~/Documents/vault/001-Fleeting/pseudocode",
    },
    template = "fleeting.md",
  },
  literature = {
    name = "literature",
    path = {
      book = "~/Documents/vault/100-Literature/books",
      quote = "~/Documents/vault/100-Literature/quotes",
      person = "~/Documents/vault/100-Literature/person",
      term = "~/Documents/vault/100-Literature/terms",
      tool = "~/Documents/vault/100-Literature/tools",
      concept = "~/Documents/vault/100-Literature/concepts",
      guide = "~/Documents/vault/100-Literature/guides",
      pattern = "~/Documents/vault/100-Literature/patterns",
      snippet = "~/Documents/vault/100-Literature/snippets",
    },
    template = "literature.md",
  },
  permanent = {
    name = "permanent",
    path = {
      prompt = "~/Documents/vault/200-Permanent",
      question = "~/Documents/vault/200-Permanent",
      permanent = "~/Documents/vault/200-Permanent",
      note = "~/Documents/vault/200-Permanent",
    },
    template = "permanent.md",
  },
  project = {
    name = "project",
    path = { project = "~/Documents/vault/300-Projects" },
    template = "project.md",
  },
}

return M

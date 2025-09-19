local M = {}
local workspaces = require("zk.workspaces").workspaces

local function expand(p)
  return vim.fn.expand(p or "")
end

local function run_zk_command(cmd_type, opts)
  local ok, zk_commands = pcall(require, "zk.commands")
  if not ok or not zk_commands or type(zk_commands.get) ~= "function" then
    vim.notify("zk.commands not available", vim.log.levels.ERROR)
    return
  end
  local fn = zk_commands.get(cmd_type)
  if type(fn) ~= "function" then
    vim.notify(("zk command not found: %s"):format(tostring(cmd_type)), vim.log.levels.ERROR)
    return
  end
  fn(opts or {})
end

local function cd_dir(dir)
  if not dir or dir == "" then
    return
  end
  local d = expand(dir)
  vim.cmd("cd " .. vim.fn.fnameescape(d))
end

-- Generic helper that handles selection vs title creation
local function create_with_possible_selection(cmd_type, dir, template, title_prompt)
  local dir_expanded = expand(dir)
  if cmd_type == "ZkNewFromTitleSelection" or cmd_type == "ZkNewFromContentSelection" then
    run_zk_command(cmd_type, { dir = dir_expanded, template = template })
  else
    local title = vim.fn.input(title_prompt or "Title: ")
    if title == nil or title == "" then
      vim.notify("Aborted: empty title", vim.log.levels.WARN)
      return
    end
    run_zk_command(cmd_type, { title = title, dir = dir_expanded, template = template })
  end
end

function M.create_note(workspace_name, cmd_type)
  local ws = workspaces[workspace_name]
  if not ws then
    vim.notify(("Workspace not found: %s"):format(tostring(workspace_name)), vim.log.levels.WARN)
    return
  end

  cmd_type = cmd_type or "ZkNew"

  if workspace_name == "literature" then
    local note_type =
      vim.fn.input("Type (book, person, quote, term, tool, snippet, guide, pattern, concept): ")
    local dir = ws.path and ws.path[note_type]
    if not dir then
      vim.notify(("Invalid literature type: %s"):format(tostring(note_type)), vim.log.levels.WARN)
      return
    end
    cd_dir(dir)
    create_with_possible_selection(cmd_type, dir, note_type .. ".md", "Title: ")
  elseif workspace_name == "fleeting" then
    local note_type = vim.fn.input("Type (fleeting, pseudocode): ")
    local dir = ws.path and ws.path[note_type]
    if not dir then
      vim.notify(("Invalid fleeting type: %s"):format(tostring(note_type)), vim.log.levels.WARN)
      return
    end
    cd_dir(dir)
    create_with_possible_selection(cmd_type, dir, note_type .. ".md", "Title: ")
  elseif workspace_name == "permanent" then
    local note_type = vim.fn.input("Type (note, permanent, question, prompt ): ")
    local dir = ws.path and ws.path[note_type]
    if not dir then
      vim.notify(("Invalid permanent type: %s"):format(tostring(note_type)), vim.log.levels.WARN)
      return
    end
    cd_dir(dir)

    -- Keep shell helper for now, but validate output
    local title = vim.fn.input("Title: ")
    if title == nil or title == "" then
      vim.notify("Aborted: empty title", vim.log.levels.WARN)
      return
    end
    local id = vim.fn.input("ID: ")
    if id == nil or id == "" then
      vim.notify("Aborted: empty ID", vim.log.levels.WARN)
      return
    end

    local cmd = string.format("~/.config/nvim/lua/scripts/zk-new-permanent.sh %q %q %q", title, id, note_type)
    local output = vim.fn.system(cmd)
    local filepath = vim.fn.trim(output or "")
    if vim.fn.filereadable(filepath) == 1 then
      vim.cmd("edit " .. vim.fn.fnameescape(filepath))
    else
      vim.notify(("Could not find the created file: %s"):format(tostring(filepath)), vim.log.levels.ERROR)
    end
  elseif workspace_name == "project" then
    local dir = ws.path and ws.path.project
    if not dir then
      vim.notify("Project workspace path not configured", vim.log.levels.WARN)
      return
    end
    cd_dir(dir)
    create_with_possible_selection(cmd_type, dir, ws.template, "project title: ")
  elseif workspace_name == "index" then
    local dir = ws.path and ws.path.index
    if not dir then
      vim.notify("Index workspace path not configured", vim.log.levels.WARN)
      return
    end
    cd_dir(dir)
    create_with_possible_selection(cmd_type, dir, ws.template, "index title: ")
  else
    vim.notify(("Unhandled workspace: %s"):format(tostring(workspace_name)), vim.log.levels.WARN)
  end
end

return M

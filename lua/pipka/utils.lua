-- [nfnl] Compiled from fnl/pipka/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local default_notify_options = {title = "pipka.nvim"}
local function set_notify_options(options)
  if options then
    options.title = (options.title or default_notify_options.title)
  else
  end
  return (options or default_notify_options)
end
local function notify(text, level, options)
  return vim.notify(text, (level or vim.log.levels.INFO), set_notify_options(options))
end
local function create_user_command(name, action, options)
  return vim.api.nvim_create_user_command(name, action, options)
end
local default_keymap_options = {noremap = true, silent = true}
local function set_keymap_options(opts)
  return vim.tbl_deep_extend("force", default_keymap_options, (opts or {}))
end
local function keymap(mode, lhs, rhs, opts)
  return vim.keymap.set(mode, lhs, rhs, set_keymap_options(opts))
end
local function buf_keymap(buffer, mode, lhs, rhs, opts)
  local options = (opts or {})
  options.buffer = buffer
  return keymap(mode, lhs, rhs, options)
end
local function get_user_defined_options(options)
  return (getmetatable(options) or options)
end
return {notify = notify, ["create-user-command"] = create_user_command, keymap = keymap, ["buf-keymap"] = buf_keymap, ["get-user-defined-options"] = get_user_defined_options}

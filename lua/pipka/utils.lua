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
return {notify = notify, ["create-user-command"] = create_user_command}

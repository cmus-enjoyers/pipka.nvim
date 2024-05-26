-- [nfnl] Compiled from fnl/pipka/init.fnl by https://github.com/Olical/nfnl, do not edit.
local create_user_command = (require("pipka.utils"))["create-user-command"]
local options = {split = "below"}
local function _1_()
  return require("pipka.pipka")(options)
end
create_user_command("Pipka", _1_, {})
local next = next
local function empty_3f(table)
  return (next(table) == nil)
end
local function setup(config)
  if not empty_3f(config) then
    options = config
    return nil
  else
    return nil
  end
end
return {setup = setup}

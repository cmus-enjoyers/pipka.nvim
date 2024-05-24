-- [nfnl] Compiled from fnl/pipka/init.fnl by https://github.com/Olical/nfnl, do not edit.
local create_user_command = (require("pipka.utils"))["create-user-command"]
local options = {}
local function _1_()
  return require("pipka.pipka")()
end
create_user_command("Pipka", _1_, {})
local function setup(config)
  options = config
  return nil
end
return {setup = setup}

local packer = require 'packer'
packer.init {
  opt_default = true,
}
local use = packer.use
packer.reset()
packer.startup(function ()
  use{
    'wbthomason/packer.nvim',
    opt = false
  }
end)

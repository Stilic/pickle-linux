local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "1.17"
self.dependencies = { pkg "user.perl" }
self.sources = {
    { "source", config.gnu_site .. "/automake/automake-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

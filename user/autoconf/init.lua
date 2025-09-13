local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "2.72"
self.dependencies = { pkg "user.perl" }
self.sources = {
    { "source", config.gnu_site .. "/autoconf/autoconf-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

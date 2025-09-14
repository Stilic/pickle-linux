local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "4.2.2"
self.dependencies = {pkg "user.gmp"}
self.sources = {
    { "source", config.gnu_site .. "/mpfr/mpfr-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "1.3.1"
-- self.dependencies = {pkg "user.gmp", pkg "user.mpfr"}
self.sources = {
    { "source", config.gnu_site .. "/mpc/mpc-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

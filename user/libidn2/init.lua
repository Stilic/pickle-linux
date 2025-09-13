local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "2.3.8"
self.sources = {
    { "source", config.gnu_site .. "/libidn/libidn2-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

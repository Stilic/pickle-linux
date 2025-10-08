local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "1.3"
self.sources = {
    { "source", config.gnu_site .. "/libunistring/libunistring-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "2.15"
self.sources = {
    { "source", config.gnu_site .. "/cpio/cpio-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

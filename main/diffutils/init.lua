local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "3.12"
self.sources = {
    { "source", config.gnu_site .. "/diffutils/diffutils-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure("")
self.pack = tools.pack_default()

return self

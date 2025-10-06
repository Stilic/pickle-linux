local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "3.8.2"
self.sources = {
    { "source", config.gnu_site .. "/bison/bison-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure("--prefix=/usr")
self.pack = tools.pack_default("source/_install/usr")

return self

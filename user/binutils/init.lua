local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "2.44"
self.dependencies = {pkg "user.flex"}
self.sources = {
    { "source", config.gnu_site .. "/binutils/binutils-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure("--disable-nls")
self.pack = tools.pack_default()

return self

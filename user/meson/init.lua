local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "1.9.1"
self.dependencies = { pkg "user.ninja" }
self.sources = {
    { "source", "https://github.com/mesonbuild/meson/releases/download/" .. self.version .. "/meson-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_python()
self.pack = tools.pack_python()

return self

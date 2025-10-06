local tools = require "tools"

local self = {}

self.version = "1.2.7-mk2"
self.sources = {
    { "source", "https://github.com/chimera-linux/musl-fts/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default("source/_install/usr/local")

return self

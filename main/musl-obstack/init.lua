local tools = require "tools"

local self = {}

self.version = "1.2.7-mk1"
self.sources = {
    { "source", "https://github.com/Stilic/musl-obstack/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_meson("")
self.pack = tools.pack_default()

return self

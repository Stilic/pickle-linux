local tools = require "tools"

local self = {}

self.version = "0.11.0"
self.dev_dependencies = { pkg "user.meson", pkg "user.pkgconf" }
self.sources = {
    { "source", "https://github.com/containers/bubblewrap/releases/download/v" .. self.version .. "/bubblewrap-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_meson()
self.pack = tools.pack_default()

return self

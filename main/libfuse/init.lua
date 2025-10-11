local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "3.17.4"
self.dev_dependencies = { pkg "user.meson", pkg "user.pkgconf" }
self.sources = {
    { "source", "https://github.com/libfuse/libfuse/releases/download/fuse-" .. self.version .. "/fuse-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_meson("-Ddisable-mtab=true")
self.pack = tools.pack_default()

return self

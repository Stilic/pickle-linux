local tools = require "tools"

local self = {}

self.version = "1.15"
self.dev_dependencies = { pkg "user.automake", pkg "user.flex" }
self.sources = {
    { "source", "https://github.com/containers/fuse-overlayfs/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_autotools()
self.pack = tools.pack_default()

return self

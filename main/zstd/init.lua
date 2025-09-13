local tools = require "tools"

local self = {}

self.version = "1.5.7"
self.sources = {
    { "source", "https://github.com/facebook/zstd/releases/download/v" .. self.version .. "/zstd-" .. self.version .. ".tar.zst" }
}

-- weird build system, using defaults is fine
self.build = tools.build_gnu_configure()
self.pack = tools.pack_default("source/_install/usr/local")

return self

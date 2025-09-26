local tools = require "tools"

local self = {}

self.version = "0.7.3"
self.sources = {
    { "source", "https://dev.midipix.org/cross/slibtool/archive/v" .. self.version .. "/slibtool-v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

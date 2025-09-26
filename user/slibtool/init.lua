local tools = require "tools"

local self = {}

self.version = "0.7.3"
self.sources = {
    { "source", "https://git.foss21.org/slibtool/snapshot/slibtool-" .. self.version .. ".tar.bz2" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

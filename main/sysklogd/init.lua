local tools = require "tools"

local self = {}

self.version = "2.7.2"
self.sources = {
    { "source", "https://github.com/troglobit/sysklogd/releases/download/v" .. self.version .. "/sysklogd-" .. self.version .. ".tar.gz"}
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

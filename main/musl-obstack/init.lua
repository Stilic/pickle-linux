local tools = require "tools"

local self = {}

self.version = "1.2.3"
self.sources = {
    { "source", "https://github.com/void-linux/musl-obstack/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_autotools("")
self.pack = tools.pack_default()

return self

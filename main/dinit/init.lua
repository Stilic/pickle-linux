local tools = require "tools"

local self = {}

self.version = "0.19.4"
self.sources = {
    { "source", "https://github.com/davmac314/dinit/releases/download/v" .. self.version .. "/dinit-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure("", "--mandir=/share/man")
self.pack = tools.pack_default()

return self

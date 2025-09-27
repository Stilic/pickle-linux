local tools = require "tools"

local self = {}

self.version = "0.21.5"
self.dev_dependencies = { pkg "user.libiconv", pkg "user.libidn2", pkg "user.libunistring", pkg "user.python" }
self.sources = {
    { "source", "https://github.com/rockdaboot/libpsl/releases/download/" .. self.version .. "/libpsl-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

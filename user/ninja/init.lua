local tools = require "tools"

local self = {}

self.version = "1.13.1"
self.dependencies = { pkg "user.python" }
self.dev_dependencies = { pkg "user.cmake" }
self.sources = {
    { "source", "https://github.com/ninja-build/ninja/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_cmake()
self.pack = tools.pack_default()

return self

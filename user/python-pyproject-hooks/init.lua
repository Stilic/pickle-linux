local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "1.2.0"
self.dependencies = { pkg "user.python" }
self.dev_dependencies = { pkg "user.python-flit-core", pkg "user.python-installer" }
self.sources = {
    { "source", "https://github.com/pypa/pyproject-hooks/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_python()
self.pack = tools.pack_python()

return self

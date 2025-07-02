local tools = require "tools"

local self = {}

self.version = "25.0"
self.dependencies = { pkg "user.python-pyparsing" }
self.dev_dependencies = { pkg "user.python-flit-core", pkg "user.python-installer" }
self.sources = {
    { "source", "https://github.com/pypa/packaging/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

self.build = tools.build_flit()
self.pack = tools.pack_python()

return self

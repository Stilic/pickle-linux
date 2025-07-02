local tools = require "tools"

local self = {}

self.version = "3.2.3"
self.dependencies = { pkg "user.python" }
self.dev_dependencies = { pkg "user.python-flit-core", pkg "user.python-installer" }
self.sources = {
    { "source", "https://github.com/pyparsing/pyparsing/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

self.build = tools.build_flit()
self.pack = tools.pack_python()

return self

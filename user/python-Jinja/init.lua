local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "3.1.6"
self.dependencies = { pkg "user.python-MarkupSafe" }
self.dev_dependencies = { pkg "user.python-gpep517", pkg "user.python-flit-core", pkg "user.python-installer" }
self.sources = {
    { "source", "https://github.com/pallets/jinja/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

self.build = tools.build_python()
self.pack = tools.pack_python()

return self

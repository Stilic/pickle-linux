local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "3.0.2"
self.dependencies = { pkg "user.python" }
self.dev_dependencies = { pkg "user.python-gpep517", pkg "user.python-setuptools", pkg "user.python-installer" }
self.sources = {
    { "source", "https://github.com/pallets/markupsafe/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

self.build = tools.build_python()
self.pack = tools.pack_python()

return self

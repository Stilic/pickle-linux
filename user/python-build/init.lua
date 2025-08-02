local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "1.2.2.post1"
--self.dependencies = { pkg "user.python-packaging", pkg "user.python-pyproject-hooks" }
--self.dev_dependencies = { pkg "user.python-flit-core", pkg "user.python-installer" }
self.sources = {
    { "source", "https://github.com/pypa/build/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

self.build = tools.build_python()
self.pack = tools.pack_python()

return self

local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "80.9.0"
self.dependencies = { pkg "user.python", pkg "user.python-packaging", pkg "user.python-installer" }
self.dev_dependencies = { pkg "user.python-gpep517" }
self.sources = {
    { "source", "https://github.com/pypa/setuptools/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_python(nil,
    "SETUPTOOLS_INSTALL_WINDOWS_SPECIFIC_FILES=0 SETUPTOOLS_DISABLE_VERSIONED_EASY_INSTALL_SCRIPT=1")
self.pack = tools.pack_python()

return self

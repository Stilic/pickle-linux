local lfs = require "lfs"
local tools = require "tools"


version = "80.9.0"
dependencies = { pkg "user.python", pkg "user.python-packaging", pkg "user.python-installer" }
dev_dependencies = { pkg "user.python-gpep517" }
sources = {
    { "source", "https://github.com/pypa/setuptools/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_python(nil,
    "SETUPTOOLS_INSTALL_WINDOWS_SPECIFIC_FILES=0 SETUPTOOLS_DISABLE_VERSIONED_EASY_INSTALL_SCRIPT=1")
pack = tools.pack_python()


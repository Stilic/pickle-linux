local tools = require "tools"

version = "25.0"
dependencies = { pkg "user.python-pyparsing" }
dev_dependencies = { pkg "user.python-flit-core", pkg "user.python-installer" }
sources = {
    { "source", "https://github.com/pypa/packaging/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_flit()

pack = tools.pack_python()

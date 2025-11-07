local tools = require "tools"

version = "25.0"
dependencies = { pkg "python-pyparsing" }
dev_dependencies = { pkg "python-flit-core", pkg "python-installer" }
sources = {
    { "source", "https://github.com/pypa/packaging/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_flit()

pack = tools.pack_python()

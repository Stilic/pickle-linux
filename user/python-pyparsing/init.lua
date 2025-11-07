local tools = require "tools"

version = "3.2.3"
dependencies = { pkg "user.python" }
dev_dependencies = { pkg "user.python-flit-core", pkg "user.python-installer" }
sources = {
    { "source", "https://github.com/pyparsing/pyparsing/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_flit()

pack = tools.pack_python()

local tools = require "tools"

version = "3.1.6"
dependencies = { pkg "user.python-MarkupSafe" }
dev_dependencies = { pkg "user.python-gpep517", pkg "user.python-flit-core", pkg "user.python-installer" }
sources = {
    { "source", "https://github.com/pallets/jinja/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_python()

pack = tools.pack_python()

local tools = require "tools"

version = "3.1.6"
dependencies = { pkg "python-MarkupSafe" }
dev_dependencies = { pkg "python-gpep517", pkg "python-flit-core", pkg "python-installer" }
sources = {
    { "source", "https://github.com/pallets/jinja/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_python()

pack = tools.pack_python()

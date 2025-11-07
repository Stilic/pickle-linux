local tools = require "tools"

version = "3.0.2"
dependencies = { pkg "python" }
dev_dependencies = { pkg "python-gpep517", pkg "python-setuptools", pkg "python-installer" }
sources = {
    { "source", "https://github.com/pallets/markupsafe/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_python()

pack = tools.pack_python()

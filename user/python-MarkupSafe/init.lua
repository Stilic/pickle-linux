local tools = require "tools"

version = "3.0.2"
dependencies = { pkg "user.python" }
dev_dependencies = { pkg "user.python-gpep517", pkg "user.python-setuptools", pkg "user.python-installer" }
sources = {
    { "source", "https://github.com/pallets/markupsafe/archive/refs/tags/" .. version .. ".tar.gz" }
}

build = tools.build_python()

pack = tools.pack_python()

local tools = require "tools"

version = "1.9.1"
dependencies = { pkg "samurai" }
dev_dependencies = { pkg "python-gpep517", pkg "python-setuptools", pkg "python-installer" }
sources = {
    { "source", "https://github.com/mesonbuild/meson/releases/download/" .. version .. "/meson-" .. version .. ".tar.gz" }
}

build = tools.build_python()

pack = tools.pack_python()

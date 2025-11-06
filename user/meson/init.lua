local lfs = require "lfs"
local tools = require "tools"


version = "1.9.1"
dependencies = { pkg "user.ninja" }
dev_dependencies = { pkg "user.python-gpep517", pkg "user.python-setuptools", pkg "user.python-installer" }
sources = {
    { "source", "https://github.com/mesonbuild/meson/releases/download/" .. version .. "/meson-" .. version .. ".tar.gz" }
}

build = tools.build_python()
pack = tools.pack_python()


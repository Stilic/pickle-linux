local tools = require "tools"


version = "0.21.5"
dev_dependencies = { pkg "user.libidn2", pkg "user.python" }
sources = {
    { "source", "https://github.com/rockdaboot/libpsl/releases/download/" .. version .. "/libpsl-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


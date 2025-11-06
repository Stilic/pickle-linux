local tools = require "tools"


version = "6.3.0"
sources = {
    { "source", "https://gmplib.org/download/gmp/gmp-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


local tools = require "tools"


version = "1.3.1"
sources = {
    { "source", "https://zlib.net/zlib-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


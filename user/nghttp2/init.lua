local tools = require "tools"


version = "1.65.0"
sources = {
    { "source", "https://github.com/nghttp2/nghttp2/releases/download/v" .. version .. "/nghttp2-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


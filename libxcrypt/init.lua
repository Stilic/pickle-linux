local tools = require "tools"

version = "4.4.38"
sources = {
    { "source", "https://github.com/besser82/libxcrypt/releases/download/v" .. version .. "/libxcrypt-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

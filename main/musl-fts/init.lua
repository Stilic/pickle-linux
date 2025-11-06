local tools = require "tools"


version = "1.2.7-mk2"
sources = {
    { "source", "https://github.com/chimera-linux/musl-fts/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default("source/_install/usr/local")


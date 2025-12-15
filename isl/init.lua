local tools = require "tools"

version = "0.24"
sources = {
    { "source", "https://libisl.sourceforge.io/isl-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

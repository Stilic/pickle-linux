local tools = require "tools"


version = "1.1.0"
sources = {
    { "source", "https://archive.hadrons.org/software/libmd/libmd-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


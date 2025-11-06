local tools = require "tools"


version = "2.5.2"
sources = {
    { "source", "https://download.savannah.nongnu.org/releases/attr/attr-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


local tools = require "tools"

version = "2.3.2"
dependencies = { pkg "attr" }
sources = {
    { "source", "https://download.savannah.nongnu.org/releases/acl/acl-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

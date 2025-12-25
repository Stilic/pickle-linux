local tools = require "tools"

version = "0.6.1"
dependencies = { pkg "libfuse", pkg "lzo", pkg "attr" }
sources = {
    { "source", "https://github.com/vasi/squashfuse/releases/download/" .. version .. "/squashfuse-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

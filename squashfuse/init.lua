local tools = require "tools"

version = "0.6.1"
-- TODO: install lzo/attr as a dep
dependencies = { pkg "libfuse" }
sources = {
    { "source", "https://github.com/vasi/squashfuse/releases/download/" .. version .. "/squashfuse-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

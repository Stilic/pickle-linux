local tools = require "tools"

version = "1.15"
dependencies = { pkg "libfuse" }
dev_dependencies = { pkg "automake", pkg "flex" }
sources = {
    { "source", "https://github.com/containers/fuse-overlayfs/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_autotools()

pack = tools.pack_default()

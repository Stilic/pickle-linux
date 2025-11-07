local tools = require "tools"

version = "1.15"
dev_dependencies = { pkg "user.automake", pkg "user.flex" }
sources = {
    { "source", "https://github.com/containers/fuse-overlayfs/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_autotools()

pack = tools.pack_default()

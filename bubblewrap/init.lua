local tools = require "tools"

version = "0.11.0"
dev_dependencies = { pkg "meson" }
sources = {
    { "source", "https://github.com/containers/bubblewrap/releases/download/v" .. version .. "/bubblewrap-" .. version .. ".tar.xz" }
}

build = tools.build_meson("-Dtests=false")

pack = tools.pack_default()

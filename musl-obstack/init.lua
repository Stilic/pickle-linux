local tools = require "tools"

version = "1.2.7-mk1"
dev_dependencies = { pkg "meson" }
sources = {
    { "source", "https://github.com/Stilic/musl-obstack/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_meson()

pack = tools.pack_default()

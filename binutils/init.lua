local tools = require "tools"
local config = require "neld.config"

version = "2.44"
dependencies = { pkg "flex" }
sources = {
    { "source", config.gnu_site .. "/binutils/binutils-" .. version .. ".tar.xz" }
}

-- TODO: remove duplicate `x86_64-pc-linux-musl` directory in / and /usr
build = tools.build_gnu_configure("--disable-nls")

pack = tools.pack_default()

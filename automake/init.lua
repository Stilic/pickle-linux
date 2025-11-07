local tools = require "tools"
local config = require "neld.config"

version = "1.17"
dependencies = { pkg "perl" }
sources = {
    { "source", config.gnu_site .. "/automake/automake-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--prefix=/usr")

pack = tools.pack_default("source/_install/usr")

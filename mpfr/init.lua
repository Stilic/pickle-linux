local tools = require "tools"
local config = require "neld.config"

version = "4.2.2"
sources = {
    { "source", config.gnu_site .. "/mpfr/mpfr-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

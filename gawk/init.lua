local tools = require "tools"
local config = require "neld.config"

version = "5.3.2"
sources = {
    { "source", config.gnu_site .. "/gawk/gawk-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--program-prefix=g")

pack = tools.pack_default()

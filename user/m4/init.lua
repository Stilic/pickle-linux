local tools = require "tools"
local config = require "neld.config"


version = "1.4.19"
sources = {
    { "source", config.gnu_site .. "/m4/m4-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


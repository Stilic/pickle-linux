local tools = require "tools"
local config = require "neld.config"


version = "3.12"
sources = {
    { "source", config.gnu_site .. "/diffutils/diffutils-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


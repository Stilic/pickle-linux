local tools = require "tools"
local config = require "neld.config"


version = "1.3"
sources = {
    { "source", config.gnu_site .. "/libunistring/libunistring-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


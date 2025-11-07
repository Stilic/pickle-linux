local tools = require "tools"
local config = require "neld.config"

version = "2.3.8"
sources = {
    { "source", config.gnu_site .. "/libidn/libidn2-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

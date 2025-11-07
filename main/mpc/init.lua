local tools = require "tools"
local config = require "neld.config"

version = "1.3.1"
sources = {
    { "source", config.gnu_site .. "/mpc/mpc-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

local tools = require "tools"
local config = require "neld.config"


version = "4.4.1"
sources = {
    { "source", config.gnu_site .. "/make/make-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


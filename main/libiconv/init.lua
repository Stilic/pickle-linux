local tools = require "tools"
local config = require "neld.config"


version = "1.18"
sources = {
    { "source", config.gnu_site .. "/libiconv/libiconv-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


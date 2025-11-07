local tools = require "tools"
local config = require "neld.config"

version = "2.15"
sources = {
    { "source", config.gnu_site .. "/cpio/cpio-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

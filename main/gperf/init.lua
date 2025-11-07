local tools = require "tools"
local config = require "neld.config"

version = "3.3"
sources = {
    { "source", config.gnu_site .. "/gperf/gperf-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

local tools = require "tools"
local config = require "neld.config"

version = "1.49.3"
dependencies = { pkg "user.perl" }
sources = {
    { "source", config.gnu_site .. "/help2man/help2man-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

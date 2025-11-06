local tools = require "tools"
local config = require "neld.config"


version = "2.72"
dependencies = { pkg "user.perl" }
sources = {
    { "source", config.gnu_site .. "/autoconf/autoconf-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--prefix=/usr")
pack = tools.pack_default("source/_install/usr")


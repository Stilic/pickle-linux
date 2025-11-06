local tools = require "tools"
local config = require "neld.config"


version = "2.5.4"
dev_dependencies = { pkg "user.help2man" }
sources = {
    { "source", config.gnu_site .. "/libtool/libtool-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


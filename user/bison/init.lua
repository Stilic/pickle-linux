local tools = require "tools"
local config = require "neld.config"


version = "3.8.2"
sources = {
    { "source", config.gnu_site .. "/bison/bison-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--prefix=/usr")
function pack()
    tools.pack_default("source/_install/usr")()
    os.remove("source/_install/usr/bin/yacc")
end


local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "3.8.2"
self.sources = {
    { "source", config.gnu_site .. "/bison/bison-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure("--prefix=/usr")
function self.pack()
    tools.pack_default("source/_install/usr")()
    os.remove("source/_install/usr/bin/yacc")
end

return self

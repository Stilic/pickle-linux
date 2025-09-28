local tools = require "tools"

local self = {}

self.version = "1.8.0"
self.sources = {
    { "source", "https://github.com/lunarmodules/luafilesystem/archive/refs/tags/v" .. self.version:gsub("%.", "_") .. ".tar.gz" }
}

self.build = tools.build_gnu_configure("")
self.pack = tools.pack_default()

return self

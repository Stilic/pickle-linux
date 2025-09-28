local tools = require "tools"
local lua = pkg "main.lua"

local self = {}

self.version = "0.0.2"
self.sources = {
    { "source", "https://github.com/Stilic/lullaby/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure("", "version=" .. lua.short_version)
self.pack = tools.pack_default()

return self

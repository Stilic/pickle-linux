local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "3.3"
self.sources = {
    { "source", config.gnu_site .. "/gperf/gperf-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure("")
self.pack = tools.pack_default()

return self

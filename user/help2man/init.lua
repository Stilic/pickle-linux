local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "1.49.3"
self.dev_dependencies = { pkg "user.perl" }
self.sources = {
    { "source", config.gnu_site .. "/help2man/help2man-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure()
self.pack = tools.pack_default()

return self

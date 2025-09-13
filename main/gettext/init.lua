local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "0.24"
self.sources = {
    { "source", config.gnu_site .. "/gettext/gettext-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure("")
function self.pack()
    tools.pack_default()()
    os.remove("filesystem/lib/GNU.Gettext.dll")
end

return self

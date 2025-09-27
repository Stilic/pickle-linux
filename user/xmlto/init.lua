local tools = require "tools"

local self = {}

self.version = "0.0.29"
self.dev_dependencies = { pkg "user.automake", pkg "user.flex", pkg "user.docbook-xsl" }
self.sources = {
    { "source", "https://www.pagure.io/xmlto/archive/" .. self.version .. "/xmlto-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_autotools()
self.pack = tools.pack_default()

return self

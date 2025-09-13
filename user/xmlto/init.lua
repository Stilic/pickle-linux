local tools = require "tools"

local self = {}

self.version = "0.0.29"
self.dev_dependencies = { pkg "user.automake", pkg "user.flex", pkg "user.docbook-xsl" }
self.sources = {
    { "source", "https://releases.pagure.org/xmlto/xmlto-" .. self.version .. ".tar.bz2" }
}

self.build = tools.build_autotools()
self.pack = tools.pack_default()

return self

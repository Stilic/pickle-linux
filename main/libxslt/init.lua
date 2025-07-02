local tools = require "tools"

local self = {}

self.version = "1.1.43"
self.sources = {
    { "source", "https://download.gnome.org/sources/libxslt/" .. self.version:sub(1, 3) .. "/libxslt-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure("", "--enable-static")
self.pack = tools.pack_default()

return self

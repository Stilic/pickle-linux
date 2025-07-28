local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "2.4.3"
self.sources = {
    { "source", "https://distfiles.ariadne.space/pkgconf/pkgconf-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure()
function self.pack()
    tools.pack_default()()
    lfs.link("pkgconf", "filesystem/usr/bin/pkg-config", true)
end

return self

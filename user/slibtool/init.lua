local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "0.7.3"
self.sources = {
    { "source", "https://git.foss21.org/slibtool/snapshot/slibtool-" .. self.version .. ".tar.bz2" }
}

self.build = tools.build_gnu_configure()
function self.pack()
    tools.pack_default()()
    lfs.link("slibtool", "filesystem/usr/bin/libtool", true)
end

return self

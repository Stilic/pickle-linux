local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "2.14.2"
self.dev_dependencies = { pkg "user.python", pkg "user.meson" }
self.sources = {
    { "source", "https://download.gnome.org/sources/libxml2/" .. self.version:sub(1, 4) .. "/libxml2-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_meson("-Dzlib=enabled")
function self.pack()
    tools.pack_default()()

    local file = "libxml2.so.16.0.2"
    lfs.link(file, "filesystem/lib/libxml2.so." .. self.version:sub(1, 1), true)
    lfs.link(file, "filesystem/lib/libxml2.so." .. self.version, true)
end

return self

local lfs = require "lfs"
local tools = require "tools"
local config = require "neld.config"

local self = {}

self.version = "5.2.37"
self.sources = {
    { "source", config.gnu_site .. "/bash/bash-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure("--disable-nls --without-bash-malloc")
function self.pack()
    tools.pack_default()()
    lfs.link("bash", "filesystem/bin/sh", true)
end

return self

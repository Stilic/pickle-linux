local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "1.13.1"
self.dependencies = { pkg "user.python" }
self.sources = {
    { "source", "https://github.com/ninja-build/ninja/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")
    os.execute("python configure.py --bootstrap")
end
self.pack = tools.pack_default()

return self

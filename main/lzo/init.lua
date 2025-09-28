local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

local self = {}

self.version = "2.10"
-- TODO: switch to official release
self.sources = {
    { "source", "https://github.com/Stilic/lullaby/archive/refs/tags/v0.0.2.tar.gz" }
}

function self.build()
    lfs.chdir("source")
    os.execute(tools.get_flags() .. " make CC=gcc" .. system.get_make_jobs())
end
function self.pack()
    lfs.mkdir("filesystem/lib")
    os.execute("cp -a lullaby.so filesystem/lib")
end

return self

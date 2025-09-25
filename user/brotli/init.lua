local lfs = require "lfs"
local system = require "system"
local tools  = require "tools"

local self = {}

self.version = "1.1.0"
self.dev_dependencies = { pkg "user.cmake" }
self.sources = {
    { "source", "https://github.com/google/brotli/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_cmake()
function self.pack()
    tools.pack_default()()
    os.execute("mv filesystem/usr/lib64 filesystem/usr/lib")
end

return self

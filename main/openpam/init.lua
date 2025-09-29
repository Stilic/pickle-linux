local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "20250531"
self.sources = {
    { "source", "https://openpam.des.dev/downloads/openpam-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure()
function self.pack()
    tools.pack_default()()
    lfs.mkdir("filesystem/lib/pkgconfig")
    os.execute("cp ../pam.pc filesystem/lib/pkgconfig")
end

return self

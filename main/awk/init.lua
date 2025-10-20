local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "20250116"
self.sources = {
    { "source", "https://github.com/onetrueawk/awk/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")
    tools.make("YACC='yacc -d -b awkgram'")
end

function self.pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/a.out filesystem/bin/awk")
end

return self

local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "2.0.3"
self.sources = {
    { "source", "https://frippery.org/make/pdpmake-" .. self.version .. ".tgz" }
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

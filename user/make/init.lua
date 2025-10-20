local lfs = require "lfs"

local self = {}

self.version = "2.0.3"
self.sources = {
    { "source", "https://frippery.org/make/pdpmake-" .. self.version .. ".tgz" }
}

function self.build()
    lfs.chdir("source")
    os.execute("gcc -o make *.c")
end

function self.pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/make filesystem/bin")
end

return self

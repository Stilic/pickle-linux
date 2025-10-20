local lfs = require "lfs"

local self = {}

self.version = "1.0.0"
self.sources = {
    { "source", "https://github.com/Stilic/sed/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")
    os.execute("gcc -o sed -std=c11 -include linux_compat.h *.c")
end

function self.pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/sed filesystem/bin")
end

return self

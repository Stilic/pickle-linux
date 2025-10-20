local lfs = require "lfs"

local self = {}

self.version = "6.6"
self.sources = {
    { "source", "https://github.com/ibara/yacc/releases/download/oyacc-" .. self.version .. "/oyacc-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")
    os.execute("cp ../../config.h .")
    os.execute("gcc -o yacc -D_GNU_SOURCE -D__unused= *.c")
end

function self.pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/yacc filesystem/bin")
end

return self

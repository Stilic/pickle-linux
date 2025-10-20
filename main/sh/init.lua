local lfs = require "lfs"

local self = {}

self.version = "7.7"
self.sources = {
    { "source", "https://github.com/ibara/oksh/releases/download/oksh-" .. self.version .. "/oksh-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")
    os.execute("cp ../../pconfig.h .")
    os.execute("gcc -o sh -D_GNU_SOURCE -DEMACS -DVI *.c")
end

function self.pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/sh filesystem/bin")
end

return self

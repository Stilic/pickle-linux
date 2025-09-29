local lfs = require "lfs"

local self = {}

self.version = "1.8.0.0.1"
self.sources = {
    { "source", "https://github.com/servalx4/cottonfetch/archive/refs/tags/i-hate-github.tar.gz" }
}

function self.pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/cottonfetch filesystem/bin")
    os.execute("chmod +x filesystem/bin/*")
end

return self

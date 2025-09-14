local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

local self = {}

self.version = "3.0"
self.sources = {
    { "source", "https://github.com/thejoshwolfe/info-zip-zip/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")

    os.execute("make" .. system.get_make_jobs() .. ' -f unix/Makefile LOCAL_ZIP="' .. tools.DEFAULT_CFLAGS .. '" generic')

    local current_dir = lfs.currentdir()
    os.execute('make -f unix/Makefile MANDIR="' ..
        current_dir .. '/share/man/man1" prefix="' .. current_dir .. '/_install" install')
end

self.pack = tools.pack_default()

return self

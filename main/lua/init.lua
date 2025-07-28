local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

local self = {}

self.version = "5.4.7"
self.sources = {
    { "source", "https://www.lua.org/ftp/lua-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")

    -- TODO: see if we can add cflags there + readline support
    os.execute("make linux" .. system.get_make_jobs())
    os.execute("make local")

    lfs.mkdir("install/lib/pkgconfig")
    local pc = io.open("install/lib/pkgconfig/lua5.4.pc", "w")
    pc:write(system.capture("make pc"))
    pc:close()
end

function self.pack()
    tools.pack_default("source/install")()
    lfs.link("/bin/lua", "filesystem/bin/lua" ..
        self.version:sub(1, self.version:find(".", self.version:find(".", 1, true) + 1, true) - 1), true)
end

return self

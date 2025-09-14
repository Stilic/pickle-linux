local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

local self = {}

self.version = "5.4.7"
self.sources = {
    { "source", "https://www.lua.org/ftp/lua-" .. self.version .. ".tar.gz" }
}

local SHORT_VERSION = self.version:sub(1, self.version:find(".", self.version:find(".", 1, true) + 1, true) - 1)

function self.build()
    lfs.chdir("source")

    -- TODO: see if we can add cflags there + readline support
    os.execute("make linux" .. system.get_make_jobs())
    os.execute("make INSTALL_MAN=../install/share/man/man1 local")

    lfs.mkdir("install/lib/pkgconfig")
    local pc = io.open("install/lib/pkgconfig/lua" .. SHORT_VERSION .. ".pc", "w")
    pc:write(system.capture("make pc"))
    pc:close()
end

function self.pack()
    tools.pack_default("source/install")()
    lfs.link("lua", "filesystem/bin/lua" .. SHORT_VERSION, true)
end

return self

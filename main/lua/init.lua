local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

local self = {}

self.version = "5.4.7"
self.short_version = self.version:sub(1, self.version:find(".", self.version:find(".", 1, true) + 1, true) - 1)
self.sources = {
    { "source", "https://www.lua.org/ftp/lua-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")

    os.execute(tools.get_flags() .. " make linux" .. system.get_make_jobs())
    os.execute("make INSTALL_MAN=../install/share/man/man1 local")

    os.execute("mkdir -p install/lib/pkgconfig")
    os.execute("cp ../../lua.pc install/lib/pkgconfig/lua" .. self.short_version .. ".pc")
end

function self.pack()
    tools.pack_default("source/install")()
    lfs.link("lua", "filesystem/bin/lua" .. self.short_version, true)
end

return self

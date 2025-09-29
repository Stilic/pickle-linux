local lfs = require "lfs"
local tools = require "tools"
local lua = pkg "main.lua"

local self = {}

self.version = "3.11.1"
self.sources = {
    { "source", "https://luarocks.github.io/luarocks/releases/luarocks-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")
    tools.make()
end

function self.pack()
    -- TODO: rework this
    os.execute("mkdir -p filesystem/etc/luarocks filesystem/bin filesystem/share/lua/" .. lua.short_version)
    os.execute("cp -ra source/build/config*.lua filesystem/etc/luarocks")
    os.execute("chmod +x source/build/luarocks*")
    os.execute("cp -ra source/build/luarocks* filesystem/bin")
    os.execute("cp -ra source/src/luarocks filesystem/share/lua/" .. lua.short_version)
end

return self

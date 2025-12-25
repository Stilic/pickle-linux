local lfs = require "lfs"
local tools = require "tools"
local lua = pkg "lua"

version = "1.0.0"
sources = {
    { "source", "https://github.com/Stilic/lullaby/archive/refs/tags/" .. version .. ".tar.gz" }
}

function build()
    lfs.chdir("source")

    tools.make("CC=cc version=" .. lua.short_version)
    os.execute('make install INSTALL="' .. lfs.currentdir() .. '/_install/lib/lua/"')
end

pack = tools.pack_default()

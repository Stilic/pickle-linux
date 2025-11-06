local tools = require "tools"
local lua = pkg "main.lua"


version = "0.0.2"
sources = {
    { "source", "https://github.com/Stilic/lullaby/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure("CC=gcc version=" .. lua.short_version)
pack = tools.pack_default()


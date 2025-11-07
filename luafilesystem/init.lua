local tools = require "tools"

version = "1.8.0"
sources = {
    { "source", "https://github.com/lunarmodules/luafilesystem/archive/refs/tags/v" .. version:gsub("%.", "_") .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

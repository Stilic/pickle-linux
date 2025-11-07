local tools = require "tools"

version = "2.6.4"
sources = {
    { "source", "https://github.com/westes/flex/releases/download/v" .. version .. "/flex-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

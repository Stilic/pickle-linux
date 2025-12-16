local tools = require "tools"

version = "1.2"
sources = {
    { "source", "https://github.com/michaelforney/samurai/releases/download/" .. version .. "/samurai-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default("source/_install/usr/local")

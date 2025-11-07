local tools = require "tools"

version = "1.2.5"
sources = {
    { "source", "https://musl.libc.org/releases/musl-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

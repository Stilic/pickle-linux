local tools = require "tools"

version = "0.192"
sources = {
    { "source", "https://sourceware.org/elfutils/ftp/" .. version .. "/elfutils-" .. version .. ".tar.bz2" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

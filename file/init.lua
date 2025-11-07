local tools = require "tools"

version = "5.46"
sources = {
    { "source", "https://astron.com/pub/file/file-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure("--enable-static")

pack = tools.pack_default()

local tools = require "tools"


version = "2.10"
sources = {
    { "source", "https://www.oberhumer.com/opensource/lzo/download/lzo-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure("--enable-shared")
pack = tools.pack_default()


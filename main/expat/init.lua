local tools = require "tools"


version = "2.7.1"
sources = {
    { "source", "https://github.com/libexpat/libexpat/releases/download/R_" .. version:gsub("%.", "_") .. "/expat-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure(nil, nil, nil, "-DXML_LARGE_SIZE")
pack = tools.pack_default()


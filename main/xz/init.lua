local tools = require "tools"


version = "5.8.1"
sources = {
    { "source", "https://github.com/tukaani-project/xz/releases/download/v" .. version .. "/xz-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


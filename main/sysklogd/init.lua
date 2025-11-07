local tools = require "tools"

version = "2.7.2"
sources = {
    { "source", "https://github.com/troglobit/sysklogd/releases/download/v" .. version .. "/sysklogd-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

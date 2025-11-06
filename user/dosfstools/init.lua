local tools = require "tools"


version = "4.2"
sources = {
    { "source", "https://github.com/dosfstools/dosfstools/releases/download/v" .. version .. "/dosfstools-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


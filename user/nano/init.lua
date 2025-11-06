local tools = require "tools"


version = "8.4"
sources = {
    { "source", "https://www.nano-editor.org/dist/v" .. version:sub(1, 1) .. "/nano-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


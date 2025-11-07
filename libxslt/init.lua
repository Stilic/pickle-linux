local tools = require "tools"

version = "1.1.43"
dev_dependencies = { pkg "python" }
sources = {
    { "source", "https://download.gnome.org/sources/libxslt/" .. version:sub(1, 3) .. "/libxslt-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--enable-static")

pack = tools.pack_default()

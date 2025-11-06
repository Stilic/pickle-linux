local tools = require "tools"


version = "1.47.1"
sources = {
    { "source", "https://mirrors.edge.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v" ..
    version .. "/e2fsprogs-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure(nil, nil, "-Wno-implicit-function-declaration")
pack = tools.pack_default()


local tools = require "tools"


version = "0.19.4"
sources = {
    { "source", "https://github.com/davmac314/dinit/releases/download/v" .. version .. "/dinit-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--mandir=/share/man")
pack = tools.pack_default()


local tools = require "tools"

version = "10.2.2"
sources = {
    { "source", "https://github.com/NetworkConfiguration/dhcpcd/releases/download/v" .. version .. "/dhcpcd-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure("--mandir=/share/man --datadir=/share")

pack = tools.pack_default()

local tools = require "tools"


version = "1.19"
sources = {
    { "source", "https://ftp.osuosl.org/pub/rpm/popt/releases/popt-" .. version:sub(1, 1) .. ".x/popt-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


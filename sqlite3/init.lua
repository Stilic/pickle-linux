local tools = require "tools"

version = "3.49.1"
sources = {
    { "source", "https://sqlite.org/2025/sqlite-autoconf-3490100.tar.gz" }
}

build = tools.build_gnu_configure()

pack = tools.pack_default()

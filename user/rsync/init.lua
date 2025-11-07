local tools = require "tools"

version = "3.4.1"
dependencies = { pkg "user.popt" }
sources = {
    { "source", "https://download.samba.org/pub/rsync/src/rsync-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure("--disable-xxhash --disable-lz4")

pack = tools.pack_default()

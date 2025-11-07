local tools = require "tools"

version = "1.5.7"
sources = {
    { "source", "https://github.com/facebook/zstd/releases/download/v" .. version .. "/zstd-" .. version .. ".tar.zst" }
}

-- weird build system, using defaults is fine
build = tools.build_gnu_configure()

pack = tools.pack_default("source/_install/usr/local")

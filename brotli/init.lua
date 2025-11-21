local tools = require "tools"

version = "1.2.0"
dev_dependencies = { pkg "cmake" }
sources = {
    { "source", "https://github.com/google/brotli/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_cmake()

pack = tools.pack_default()

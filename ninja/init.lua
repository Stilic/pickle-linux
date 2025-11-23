local tools = require "tools"

version = "1.13.2"
dependencies = { pkg "python" }
dev_dependencies = { pkg "cmake" }
sources = {
    { "source", "https://github.com/ninja-build/ninja/archive/refs/tags/v" .. version .. ".tar.gz" }
}

build = tools.build_cmake()

pack = tools.pack_default()

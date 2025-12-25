local tools = require "tools"

version = "1.36.1"
dependencies = { pkg "bzip2" }
sources = {
    { "source", "https://github.com/mirror/busybox/archive/refs/tags/" .. version:gsub("%.", "_") .. ".tar.gz" }
}

function build()
    tools.build_kconfig()()
    os.execute("make install")
end

pack = tools.pack_default()

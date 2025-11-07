local tools = require "tools"

version = "1.36.1"
sources = {
    { "source", "https://busybox.net/downloads/busybox-" .. version .. ".tar.bz2" }
}

function build()
    tools.build_kconfig()()
    os.execute("make install")
end

pack = tools.pack_default()

local tools = require "tools"


version = "2.6.0"
sources = {
    { "source", "https://github.com/seccomp/libseccomp/releases/download/v" .. version .. "/libseccomp-" .. version .. ".tar.gz" }
}

build = tools.build_gnu_configure()
pack = tools.pack_default()


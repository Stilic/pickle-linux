local lfs = require "lfs"
local tools = require "tools"
local python = pkg "user.python"
local flit_core = pkg "user.python-flit-core"

local self = {}

self.version = "0.7.0"
self.dependencies = { pkg "user.python" }
self.dev_dependencies = { pkg "user.python-flit-core" }
self.sources = {
    { "source", "https://github.com/pypa/installer/archive/refs/tags/" .. self.version .. ".tar.gz" },
    { "flit",   flit_core.sources[1][2] }
}

self.build = tools.build_flit()
function self.pack()
    lfs.chdir("flit/flit_core")

    os.execute("python bootstrap_install.py --installdir ../../filesystem/usr/lib/python" ..
        python.short_version .. "/site-packages ../../source/dist/*.whl")
    os.execute("install -Dm644 ../../source/LICENSE -t ../filesystem/usr/share/licenses/" .. self.name)
end

return self

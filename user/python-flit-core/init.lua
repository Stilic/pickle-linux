local lfs = require "lfs"
local tools = require "tools"
local python = pkg "user.python"

local self = {}

self.version = "3.12.0"
self.dependencies = { pkg "user.python" }
self.sources = {
    { "source", "https://github.com/pypa/flit/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

self.build = tools.build_flit("source/flit_core")
function self.pack()
    lfs.chdir("source/flit_core")

    os.execute("python bootstrap_install.py --installdir ../../filesystem/usr/lib/python" ..
        python.short_version .. "/site-packages dist/*.whl")
    os.execute("install -Dm644 LICENSE -t ../../filesystem/usr/share/licenses/" .. self.name)
end

return self

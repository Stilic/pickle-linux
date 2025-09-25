local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "3.12.0"
self.dependencies = { pkg "user.python" }
self.sources = {
    { "source", "https://github.com/pypa/flit/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

self.build = tools.build_flit()
function self.pack()
    lfs.chdir("source")

    os.execute("python bootstrap_install.py --installdir ../filesystem dist/*.whl")
    os.execute("install -Dm644 LICENSE -t ../filesystem/usr/share/licenses/" .. self.name)
end

return self

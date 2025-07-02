local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "0.7.0"
self.dependencies = { pkg "user.python" }
self.dev_dependencies = { pkg "user.python-flit-core" }
self.sources = {
    { "source", "https://github.com/pypa/installer/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

self.build = tools.build_flit()
function self.pack()
    lfs.chdir("source")

    os.execute("python -m installer --destdir ../filesystem dist/*.whl")
    os.execute("install -Dm644 LICENSE -t ../filesystem/usr/share/licenses/" .. self.name)
end

return self

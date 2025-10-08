local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "2.49.0"
self.dependencies = { pkg "user.curl" }
self.sources = {
    { "source", "https://www.kernel.org/pub/software/scm/git/git-" .. self.version .. ".tar.xz" }
}

function self.build()
    lfs.chdir("source")
    os.execute("make configure")
    tools.build_gnu_configure("--prefix=/usr NO_TCLTK=YesPlease", "")()
end

self.pack = tools.pack_default("source/_install/usr")

return self

local lfs = require "lfs"
local python = pkg "user.python"

local self = {}

self.version = "0.7.0"
self.dependencies = { pkg "user.python" }
self.sources = {
    { "source", "https://github.com/gentoo/gpep517/archive/refs/tags/v19.tar.gz" }
}

function self.pack()
    local install_dir = "filesystem/usr/lib/python" .. python.short_version .. "/site-packages"
    os.execute("mkdir -p " .. install_dir)
    os.execute("cp -ra source/gpep517 " .. install_dir)
    os.execute("python3 -m compileall " .. install_dir)
end

return self

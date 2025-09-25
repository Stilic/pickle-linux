local lfs = require "lfs"
local python = pkg "user.python"

local self = {}

self.version = "0.7.0"
self.dependencies = { pkg "user.python" }
self.sources = {
    { "source", "https://files.pythonhosted.org/packages/py3/i/installer/installer-" .. self.version .. "-py3-none-any.whl" }
}

function self.pack()
    local install_dir = "filesystem/usr/lib/python" .. python.short_version .. "/site-packages"
    os.execute("mkdir -p " .. install_dir)
    os.execute("cp -ra source/* " .. install_dir)
    os.execute("python3 -m compileall " .. install_dir)
end

return self

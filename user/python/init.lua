local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "3.13.3"
self.dev_dependencies = { pkg "user.perl" }
self.sources = {
    { "source", "https://www.python.org/ftp/python/" .. self.version .. "/Python-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure(nil, "--enable-shared --with-system-expat --without-ensurepip")
function self.pack()
    tools.pack_default()()

    local major_version = self.version:sub(1, 1)

    for _, v in ipairs({ "python" .. major_version, "idle" .. major_version, "pydoc" .. major_version }) do
        lfs.link(v, "filesystem/usr/bin/" .. v:sub(1, -2), true)
    end

    lfs.link("python" .. major_version .. "-config", "filesystem/usr/bin/python-config", true)
    lfs.link("python" .. major_version .. ".1", "filesystem/usr/share/man/man1/python.1", true)
end

return self

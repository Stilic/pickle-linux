local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "1.7.1"
self.dev_dependencies = {
    pkg "user.muon", pkg "user.pkgconf",
    pkg "user.flex"
}
self.sources = {
    { "source", "https://github.com/linux-pam/linux-pam/releases/download/v" .. self.version .. "/Linux-PAM-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_meson("/", "-Ddocdir=/share/doc/pam -Dvendordir=/share/pam -Dnis=disabled -Daudit=disabled -Dselinux=disabled")

function self.pack()
    tools.pack_default()()

    os.execute("rm -r filesystem/lib/systemd")
end

return self

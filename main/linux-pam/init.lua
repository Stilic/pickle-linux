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

-- TODO: add docbook 5 for docs
self.build = tools.build_meson("/", "-Ddocdir=/share/doc/pam -Dvendordir=/share/pam -Ddocs=disabled -Dnis=disabled -Daudit=disabled -Dselinux=disabled")
self.pack = tools.pack_default()

return self

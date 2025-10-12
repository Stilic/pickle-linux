local tools = require "tools"

local self = {}

self.version = "2.41"
self.dev_dependencies = { pkg "user.meson" }
self.sources = {
    { "source", "https://www.kernel.org/pub/linux/utils/util-linux/v" .. self.version .. "/util-linux-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_meson(
    "-Dbuild-newgrp=disabled -Dbuild-more=disabled -Dbuild-kill=disabled -Dbuild-nologin=disabled -Dbuild-liblastlog2=disabled -Dbuild-pam-lastlog2=disabled")
self.pack = tools.pack_default()

return self

local lfs = require "lfs"
local tools = require "tools"

local self = {}

-- TODO: add scdoc
self.version = "0.1.10"
self.dev_dependencies = { pkg "user.meson", pkg "user.pkgconf" }
self.sources = {
    { "source", "https://github.com/chimera-linux/turnstile/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_meson("/", "-Ddinit=enabled -Drunit=disabled -Dpam_moddir=/lib/security -Dmanage_rundir=true -Dman=false")
function self.pack()
    tools.pack_default()()

    os.execute("cp ../turnstiled filesystem/etc/dinit.d")
    lfs.mkdir("filesystem/etc/dinit.d/boot.d")
    lfs.link("../turnstiled", "filesystem/etc/dinit.d/boot.d/turnstiled", true)
end

return self

local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

local self = {}

self.version = "6.14.2"
self.dev_dependencies = { pkg "user.flex", pkg "user.bison", pkg "user.elfutils", pkg "user.dosfstools" }
self.sources = {
    { "source", "https://cdn.kernel.org/pub/linux/kernel/v"
    .. self.version:sub(1, self.version:find(".", 1, true) - 1)
    .. ".x/linux-" .. self.version .. ".tar.xz" }
}

-- TODO: add config for other architectures than x86_64
self.build = tools.build_kconfig()

function self.pack()
    lfs.chdir("source")
    local path = "../filesystem/lib/modules/" .. system.capture("make -s kernelrelease")

    os.execute("mkdir -p " .. path)
    os.execute("cp -ra " .. system.capture("make -s image_name") .. " " .. path .. "/vmlinuz")

    os.execute(
        "ZSTD_CLEVEL=19 make INSTALL_MOD_PATH=../filesystem INSTALL_MOD_STRIP=1 DEPMOD=/doesnt/exist modules_install")
    os.remove(path .. "/build")

    os.execute("make mrproper headers_install")
    os.execute("cp -ra include ../filesystem")
end

return self

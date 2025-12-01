local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

version = "6.14.2"
dev_dependencies = { pkg "flex", pkg "bison", pkg "elfutils", pkg "dosfstools" }
sources = {
    { "source", "https://cdn.kernel.org/pub/linux/kernel/v"
    .. version:sub(1, version:find(".", 1, true) - 1)
    .. ".x/linux-" .. version .. ".tar.xz" }
}

-- TODO: add config for other architectures than x86_64
build = tools.build_kconfig()

function pack()
    lfs.chdir("source")
    local path = "../filesystem/lib/modules/" .. system.capture("make -s kernelrelease")

    os.execute("mkdir -p " .. path)
    os.execute("cp -ra " .. system.capture("make -s image_name") .. " " .. path .. "/vmlinuz")

    os.execute(
        "ZSTD_CLEVEL=19 make INSTALL_MOD_PATH=../filesystem INSTALL_MOD_STRIP=1 DEPMOD=/doesnt/exist modules_install")
    os.remove(path .. "/build")

    os.execute("make headers")
    os.execute("cp -ra usr/include ../filesystem")
    os.execute("rm -r ../filesystem/include/drm")
    os.execute([[find ../filesystem/include \! -name *.h -type f -exec rm {} \;]])
end

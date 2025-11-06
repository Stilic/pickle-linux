local lfs = require "lfs"
local tools = require "tools"


version = "2.14.2"
dev_dependencies = { pkg "user.meson", pkg "user.python", pkg "user.git" }
sources = {
    { "source", "https://download.gnome.org/sources/libxml2/" .. version:sub(1, 4) .. "/libxml2-" .. version .. ".tar.xz" }
}

build = tools.build_meson("-Dzlib=enabled")
function pack()
    tools.pack_default()()

    local file = "libxml2.so.16.0.2"
    lfs.link(file, "filesystem/lib/libxml2.so." .. version:sub(1, 1), true)
    lfs.link(file, "filesystem/lib/libxml2.so." .. version, true)
end


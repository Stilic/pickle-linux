local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "258"
self.dev_dependencies = {
    pkg "user.meson", pkg "user.pkgconf", pkg "user.perl",
    pkg "user.python-Jinja"
}
self.sources = {
    { "source", "https://github.com/systemd/systemd/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

-- from https://www.linuxfromscratch.org/lfs/view/stable/chapter08/udev.html
function self.build()
    local build_dir = lfs.currentdir()
    lfs.chdir("source")

    os.execute([[find . -type f | xargs sed -i 's/#!\/usr\/bin\/env/#!\/bin\/env/g']])
    os.execute([[
        sed -e 's/GROUP="render"/GROUP="video"/' \
            -e 's/GROUP="sgx", //'               \
            -i rules.d/50-udev-default.rules.in
    ]])
    os.execute("sed -i '/systemd-sysctl/s/^/#/' rules.d/99-systemd.rules.in")
    os.execute([[
        sed -e '/NETWORK_DIRS/s/systemd/udev/' \
            -i src/libsystemd/sd-network/network-util.h
    ]])

    os.execute(tools.get_flags() .. " meson setup build --buildtype=release --prefix=/ -D mode=release -D dev-kvm-mode=0660 -D link-udev-shared=false -D logind=false -D vconsole=false")

    lfs.chdir("build")
    os.execute([[
        ninja udevadm systemd-hwdb                                         \
            $(ninja -n | grep -Eo '(src/(lib)?udev|rules.d|hwdb.d)/[^ ]*') \
            $(realpath libudev.so --relative-to .)                         \
            $(grep "'name' :" ../src/udev/meson.build | \
                      awk '{print $3}' | tr -d ",'" | grep -v 'udevadm')
    ]])

    os.execute('DESTDIR="' .. build_dir .. '/_install" meson install -C build')
end

function self.pack()
    tools.pack_default()()

    lfs.chdir("filesystem")
    os.execute("mv usr/share/* share")
    os.execute(
        "rm -r usr etc/systemd lib/*systemd* lib/pkgconfig/libsystemd.pc share/dbus-1 share/pkgconfig/systemd.pc share/polkit-1 bin/bootctl share/man/man1/bootctl.1 share/man/man1/ukify.1 share/man/man5/loader.conf.5 share/man/man7/linux* share/man/man7/*-boot.7 share/man/man7/*-stub.7")

    -- TODO: add tmpfiles
    os.execute("cp ../../80-net-name-slot.rules lib/udev/rules.d")

    lfs.link("../bin/udevadm", "lib/udevd", true)

    os.execute("cp ../../udevd.wrapper lib")
    os.execute("cp ../../dinit-devd lib")
end

return self

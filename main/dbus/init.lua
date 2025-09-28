local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "1.16.2"
self.dev_dependencies = { pkg "user.meson", pkg "user.pkgconf", pkg "user.xmlto" }
self.sources = {
    { "source", "https://dbus.freedesktop.org/releases/dbus/dbus-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_meson("/",
    "-Dasserts=false -Ddbus_user=dbus -Ddoxygen_docs=disabled -Depoll=enabled -Dinotify=enabled -Dselinux=disabled -Dsystem_pid_file=/run/dbus/pid -Dsystem_socket=/run/dbus/system_bus_socket -Dsystemd=disabled -Duser_session=false -Dtraditional_activation=true -Dxml_docs=disabled -Dmodular_tests=disabled")
function self.pack()
    tools.pack_default()()

    lfs.chdir("filesystem")

    lfs.mkdir("lib")
    os.execute("cp ../../dbus-session.wrapper lib")

    os.execute("mkdir -p etc/X11/Xsession.d")
    os.execute("cp ../../01dbus-env etc/X11/Xsession.d")

    -- TODO: add sysusers and tmpfiles
end

return self

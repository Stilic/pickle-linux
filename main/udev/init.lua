local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "257.4"
self.dev_dependencies = {
    pkg "user.meson", pkg "user.pkgconf", pkg "user.perl",
    pkg "user.python-Jinja"
}
self.sources = {
    { "source", "https://github.com/systemd/systemd/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

-- from https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-apps/systemd-utils/files?id=8c128ff779a89ca0f9559f72e23a43db15058583
function self.build()
    os.execute([[find source -type f | xargs sed -i 's/#!\/usr\/bin\/env/#!\/bin\/env/g']])
    tools.build_meson("/",
        "-Dsysvinit-path= -Dacl=enabled -Dadm-group=false -Danalyze=false -Dapparmor=disabled -Daudit=disabled -Dbacklight=false -Dbinfmt=false -Dbpf-framework=disabled -Dbzip2=disabled -Dcoredump=false -Ddbus=disabled -Delfutils=disabled -Denvironment-d=false -Dfdisk=disabled -Dgcrypt=disabled -Dglib=disabled -Dgshadow=false -Dgnutls=disabled -Dhibernate=false -Dhostnamed=false -Didn=false -Dima=false -Dinitrd=false -Dfirstboot=false -Dldconfig=false -Dlibcryptsetup=disabled -Dlibcurl=disabled -Dlibfido2=disabled -Dlibidn=disabled -Dlibidn2=disabled -Dlibiptc=disabled -Dlocaled=false -Dlogind=false -Dlz4=disabled -Dmachined=false -Dmicrohttpd=disabled -Dnetworkd=false -Dnscd=false -Dnss-myhostname=false -Dnss-resolve=disabled -Dnss-systemd=false -Doomd=false -Dopenssl=disabled -Dp11kit=disabled -Dpam=disabled -Dpcre2=disabled -Dpolkit=disabled -Dportabled=false -Dpstore=false -Dpwquality=disabled -Drandomseed=false -Dresolve=false -Drfkill=false -Dseccomp=disabled -Dsmack=false -Dsysext=false -Dtimedated=false -Dtimesyncd=false -Dtpm=false -Dqrencode=disabled -Dquotacheck=false -Duserdb=false -Dutmp=false -Dvconsole=false -Dwheel-group=false -Dxdg-autostart=false -Dxkbcommon=disabled -Dxz=disabled -Dzlib=disabled -Dzstd=disabled",
        nil, nil, "-D__UAPI_DEF_ETHHDR=0")()
end

function self.pack()
    lfs.chdir("filesystem")

    lfs.mkdir("bin")
    os.execute("cp ../source/_install/bin/udevadm bin")

    lfs.mkdir("etc")
    os.execute("cp -r ../source/_install/etc/udev etc")

    lfs.mkdir("include")
    os.execute("cp ../source/_install/include/* include")

    lfs.mkdir("lib")
    os.execute("cp ../source/_install/lib/* lib")
    os.execute("cp -r ../source/_install/lib/udev lib")
    lfs.link("libsystemd.so", "lib/libsystemd-shared-" .. self.version:find(".", 1, true) .. ".so", true)

    os.execute("mkdir -p share/bash-completion/completions")
    os.execute("cp -r ../source/_install/share/pkgconfig share")
    os.execute("cp ../source/_install/share/bash-completion/completions/udevadm share/bash-completion/completions")

    -- TODO: add tmpfiles
    os.execute("cp ../../80-net-name-slot.rules lib/udev/rules.d")

    lfs.link("../bin/udevadm", "lib/udevd", true)

    os.execute("cp ../../udevd.wrapper lib")
    os.execute("cp ../../dinit-devd lib")
end

return self

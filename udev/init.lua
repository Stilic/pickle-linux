local lfs = require "lfs"
local tools = require "tools"

version = "256.17"
dev_dependencies = { pkg "bash", pkg "meson", pkg "pkgconf", pkg "perl", pkg "python-Jinja" }
sources = {
    { "source", "https://github.com/systemd/systemd/archive/refs/tags/v" .. version .. ".tar.gz" }
}

-- from https://gitweb.gentoo.org/repo/gentoo.git/tree/sys-apps/systemd-utils?id=0ad96e879b651cc7e8214159d5841d6b633bef8a
build = tools.build_meson(
    "-Ddatadir=/lib -Dsysvinit-path= -Dadm-group=false -Danalyze=false -Dapparmor=disabled -Daudit=disabled -Dbacklight=false -Dbinfmt=false -Dbpf-framework=disabled -Dbzip2=disabled -Dcoredump=false -Ddbus=disabled -Delfutils=disabled -Denvironment-d=false -Dfdisk=disabled -Dgcrypt=disabled -Dglib=disabled -Dgshadow=false -Dgnutls=disabled -Dhibernate=false -Dhostnamed=false -Didn=false -Dima=false -Dinitrd=false -Dfirstboot=false -Dldconfig=false -Dlibcryptsetup=disabled -Dlibcurl=disabled -Dlibfido2=disabled -Dlibidn=disabled -Dlibidn2=disabled -Dlibiptc=disabled -Dlocaled=false -Dlogind=false -Dlz4=disabled -Dmachined=false -Dmicrohttpd=disabled -Dnetworkd=false -Dnscd=false -Dnss-myhostname=false -Dnss-resolve=disabled -Dnss-systemd=false -Doomd=false -Dopenssl=disabled -Dp11kit=disabled -Dpam=disabled -Dpcre2=disabled -Dpolkit=disabled -Dportabled=false -Dpstore=false -Dpwquality=disabled -Drandomseed=false -Dresolve=false -Drfkill=false -Dseccomp=disabled -Dsmack=false -Dsysext=false -Dtimedated=false -Dtimesyncd=false -Dtpm=false -Dqrencode=disabled -Dquotacheck=false -Duserdb=false -Dutmp=false -Dvconsole=false -Dwheel-group=false -Dxdg-autostart=false -Dxkbcommon=disabled -Dxz=disabled -Dzlib=disabled -Dzstd=disabled -Dlink-boot-shared=false -Dlink-journalctl-shared=false -Dlink-networkd-shared=false -Dlink-systemctl-shared=false -Dlink-timesyncd-shared=false -Dlink-udev-shared=false -Dsplit-bin=false",
    nil, nil, "-D__UAPI_DEF_ETHHDR=0")

-- TODO: add tmpfiles
function pack()
    lfs.chdir("filesystem")

    lfs.mkdir("bin")
    os.execute("cp -a ../source/_install/bin/udevadm bin")

    lfs.mkdir("etc")
    os.execute("cp -ra ../source/_install/etc/udev etc")

    lfs.mkdir("include")
    os.execute("cp -a ../source/_install/include/libudev.h include")

    os.execute("mkdir -p lib/pkgconfig")
    os.execute("cp -ra ../source/_install/lib/*udev* lib")
    os.execute("cp -a ../source/_install/lib/pkgconfig/udev.pc lib/pkgconfig")

    os.execute("mkdir -p share/bash-completion/completions")
    os.execute("cp -a ../source/_install/lib/bash-completion/completions/udevadm share/bash-completion/completions")

    os.execute("cp -a ../../80-net-name-slot.rules lib/udev/rules.d")

    lfs.link("../bin/udevadm", "lib/udevd", true)

    os.execute("cp -a ../../udevd.wrapper lib")
    os.execute("cp -a ../../dinit-devd lib")
end

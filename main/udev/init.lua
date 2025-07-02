local lfs = require "lfs"
local tools = require "tools"

local self = {}

self.version = "256.11"
self.dev_dependencies = {
    pkg "user.muon", pkg "user.pkgconf", pkg "user.perl", pkg "user.gperf",
    pkg "user.acl", pkg "user.python-Jinja"
}
self.sources = {
    { "source", "https://github.com/systemd/systemd/archive/refs/tags/v" .. self.version .. ".tar.gz" }
}

self.build = tools.build_meson("/",
    "-Dtime-epoch=1 -Dacl=enabled -Dadm-group=false -Danalyze=false -Dapparmor=disabled -Daudit=disabled -Dbacklight=false -Dbinfmt=false -Dbootloader=disabled -Dbpf-framework=disabled -Dbzip2=disabled -Dcoredump=false -Ddbus=disabled -Defi=false -Delfutils=disabled -Denvironment-d=false -Dfdisk=disabled -Dgcrypt=disabled -Dglib=disabled -Dgshadow=false -Dgnutls=disabled -Dhibernate=false -Dhostnamed=false -Didn=false -Dima=false -Dinitrd=false -Dfirstboot=false -Dkernel-install=false -Dldconfig=false -Dlibcryptsetup=disabled -Dlibcurl=disabled -Dlibfido2=disabled -Dlibidn=disabled -Dlibidn2=disabled -Dlibiptc=disabled -Dlocaled=false -Dlogind=false -Dlz4=disabled -Dmachined=false -Dmicrohttpd=disabled -Dnetworkd=false -Dnscd=false -Dnss-myhostname=false -Dnss-resolve=disabled -Dnss-systemd=false -Doomd=false -Dopenssl=disabled -Dp11kit=disabled -Dpam=disabled -Dpcre2=disabled -Dpolkit=disabled -Dportabled=false -Dpstore=false -Dpwquality=disabled -Drandomseed=false -Dresolve=false -Drfkill=false -Dseccomp=disabled -Dselinux=disabled -Dsmack=false -Dsysext=false -Dsysusers=false -Dtimedated=false -Dtimesyncd=false -Dtmpfiles=false -Dtpm=false -Dqrencode=disabled -Dquotacheck=false -Duserdb=false -Dukify=disabled -Dutmp=false -Dvconsole=false -Dwheel-group=false -Dxdg-autostart=false -Dxkbcommon=disabled -Dxz=disabled -Dzlib=disabled -Dzstd=disabled -Dhwdb=true -Dman=enabled -Dstandalone-binaries=true -Dstatic-libudev=true -Dtests=false -Dlink-boot-shared=false -Dlink-journalctl-shared=false -Dlink-networkd-shared=false -Dlink-systemctl-shared=false -Dlink-timesyncd-shared=false -Dlink-udev-shared=false -Dsplit-bin=false -Dsysvinit-path= -Drpmmacrosdir=no -Dpamconfdir=no")

function self.pack()
    tools.pack_default()()

    lfs.chdir("filesystem")
    os.execute(
        "rm -r etc/systemd lib/*systemd* lib/pkgconfig/libsystemd.pc share/dbus-1 share/pkgconfig/systemd.pc share/polkit-1 bin/bootctl share/man/man1/bootctl.1 share/man/man1/ukify.1 share/man/man5/loader.conf.5 share/man/man7/linux* share/man/man7/*-boot.7 share/man/man7/*-stub.7")

    -- TODO: add tmpfiles and service
    os.execute("cp ../../80-net-name-slot.rules lib/udev/rules.d")
    os.execute("cp ../../udevd.wrapper lib")
    os.execute("cp ../../dinit-devd lib")
end

return self

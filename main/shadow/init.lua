local tools = require "tools"

version = "4.18.0"
sources = {
    { "source", "https://github.com/shadow-maint/shadow/releases/download/" .. version .. "/shadow-" .. version .. ".tar.xz" }
}

build = tools.build_gnu_configure(
    "--enable-shared --enable-lastlog --disable-static --with-acl --with-attr --without-libpam --without-libbsd --without-selinux --without-nscd --disable-nls --enable-subordinate-ids --disable-account-tools-setuid")

function pack()
    tools.pack_default()()
    os.execute("rm -r filesystem/etc/pam.d")
end

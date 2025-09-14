local tools = require "tools"

local self = {}

self.version = "4.18.0"
self.sources = {
    { "source", "https://github.com/shadow-maint/shadow/releases/download/" .. self.version .. "/shadow-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure("", "--enable-shared --enable-lastlog --disable-static --with-acl --with-attr --without-libpam --without-libbsd --without-selinux --without-nscd --disable-nls --enable-subordinate-ids --disable-account-tools-setuid")

function self.pack()
    tools.pack_default()()
    os.execute("rm -r filesystem/etc/pam.d")
end

return self

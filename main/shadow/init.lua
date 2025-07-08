local tools = require "tools"

local self = {}

self.version = "4.18.0"
self.sources = {
    { "source", "https://github.com/shadow-maint/shadow/releases/download/" .. self.version .. "/shadow-" .. self.version .. ".tar.xz" }
}

self.build = tools.build_gnu_configure("", "--enable-shared --enable-lastlog --disable-static --with-acl --with-attr --with-libpam --without-libbsd --without-selinux --without-nscd --disable-nls --enable-subordinate-ids --disable-account-tools-setuid")
self.pack = tools.pack_default()

return self

local tools = require "tools"

local self = {}

self.version = "3.4.1"
self.dependencies = { pkg "user.attr", pkg "user.acl", pkg "user.popt" }
self.sources = {
    { "source", "https://download.samba.org/pub/rsync/src/rsync-" .. self.version .. ".tar.gz" }
}

self.build = tools.build_gnu_configure(nil, "--disable-xxhash --disable-lz4")
self.pack = tools.pack_default()

return self

local tools = require "tools"

local self = {}

self.version = "8.13.0"
self.dependencies = { pkg "user.libpsl" }
self.sources = {
    { "source", "https://curl.se/download/curl-" .. self.version .. ".tar.xz" }
}

function self.build()
    os.execute([[find source -type f | xargs sed -i 's/#!\/usr\/bin\/env/#!\/bin\/env/g']])
    tools.build_gnu_configure(nil, "--with-openssl")()
end
self.pack = tools.pack_default()

return self

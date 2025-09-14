local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

-- TODO: build docs
local self = {}
self.version = "0.12.1"
self.sources = {
    { "source", "https://github.com/ifupdown-ng/ifupdown-ng/archive/refs/tags/ifupdown-ng-" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")
    -- TODO: see if we can add cflags there
    lfs.mkdir("_install")
    os.execute('make all EXECUTOR_PATH=/libexec/ifupdown-ng DESTDIR="' .. lfs.currentdir() .. '/_install"' .. system.get_make_jobs())
end

self.pack = tools.pack_default()

return self

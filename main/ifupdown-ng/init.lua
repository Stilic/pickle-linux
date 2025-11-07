local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

version = "0.12.1"
sources = {
    { "source", "https://github.com/ifupdown-ng/ifupdown-ng/archive/refs/tags/ifupdown-ng-" .. version .. ".tar.gz" }
}

-- TODO: build docs
function build()
    lfs.chdir("source")
    -- TODO: see if we can add cflags there
    lfs.mkdir("_install")
    os.execute('make all install EXECUTOR_PATH=/libexec/ifupdown-ng DESTDIR="' ..
        lfs.currentdir() .. '/_install"' .. system.get_make_jobs())
end

pack = tools.pack_default()

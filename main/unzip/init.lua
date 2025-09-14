local lfs = require "lfs"
local system = require "system"
local tools = require "tools"

local self = {}

self.version = "6.0"
self.sources = {
    { "source", "https://github.com/thejoshwolfe/info-zip-unzip/archive/refs/tags/" .. self.version .. ".tar.gz" }
}

function self.build()
    lfs.chdir("source")

    os.execute("make" .. system.get_make_jobs() ..
        ' -f unix/Makefile CF="' ..
        tools.DEFAULT_CFLAGS ..
        ' -I. -DWILD_STOP_AT_DIR -DLARGE_FILE_SUPPORT -DUNICODE_SUPPORT -DUNICODE_WCHAR -DUTF8_MAYBE_NATIVE -DNO_LCHMOD -DDATE_FORMAT=DF_YMD -DNATIVE" unzips')

    local current_dir = lfs.currentdir()
    os.execute('make -f unix/Makefile MANDIR="' ..
        current_dir .. '/share/man/man1" prefix="' .. current_dir .. '/_install" install')
end

self.pack = tools.pack_default()

return self

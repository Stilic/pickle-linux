local lfs = require "lfs"


version = "1.8.0.0.1"
dependencies = { pkg "user.bash" }
sources = {
    { "source", "https://github.com/servalx4/cottonfetch/archive/refs/tags/i-hate-github.tar.gz" }
}

function pack()
    lfs.mkdir("filesystem/bin")
    os.execute("cp source/cottonfetch filesystem/bin")
    os.execute("chmod +x filesystem/bin/*")
end


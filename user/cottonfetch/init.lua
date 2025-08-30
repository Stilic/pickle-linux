local self = {}

self.version = "1.8"
self.sources = {
    { "source", "https://github.com/servalx4/cottonfetch/archive/refs/tags/holy-shit-why-do-i-have-to-keep-making-tags-bro-who-needs-ts.tar.gz" }
}

function self.pack()
    os.execute("mkdir -p filesystem/usr/bin")
    os.execute("cp source/cottonfetch filesystem/usr/bin")
    os.execute("chmod +x filesystem/usr/bin/*")
end

return self

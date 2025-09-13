local lfs = require "lfs"

local self = {}

self.version = "1"

function self.pack()
    os.execute("cp -ra ../root/* filesystem")
end

return self

local lfs = require "lfs"


version = "1"

function pack()
    os.execute("cp -ra ../root/* filesystem")
end


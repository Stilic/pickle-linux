local system = require "system"
local tools = require "tools"
local lfs = require "lfs"

version = "21.1.6"
dependencies = { pkg "binutils" }
dev_dependencies = { pkg "cmake", pkg "python" }
sources = {
    { "source", "https://github.com/llvm/llvm-project/releases/download/llvmorg-" .. version .. "/llvm-project-" .. version .. ".src.tar.xz" }
}

local arch = ""
if buildmode then
    if system.architecture == "x86_64" then
        arch = "X86"
    elseif system.architecture == "aarch64" then
        arch = "AArch64"
    elseif system.architecture == "ppc64le" or system.architecture == "ppc64" or system.architecture == "ppc" then
        arch = "PowerPC"
    elseif system.architecture == "riscv64" then
        arch = "RISCV64"
    elseif system.architecture == "armv7l" or system.architecture == "armv7" or system.architecture == "armhf" then
        arch = "ARM"
    elseif system.architecture == "loongarch64" or system.architecture == "loongarch32" then
        arch = "LoongArch"
    end
end
local function gen_build(part, projects, runtimes)
    local options = ""

    if projects then
        options = " -DLLVM_ENABLE_PROJECTS="

        local l = #projects
        for i, project in ipairs(projects) do
            options = options .. project
            if i ~= l then
                options = options .. ";"
            end
        end
    end

    if runtimes then
        options = options .. " -DLLVM_ENABLE_RUNTIMES="

        local l = #runtimes
        for i, runtime in ipairs(runtimes) do
            options = options .. runtime
            if i ~= l then
                options = options .. ";"
            end
        end
    end

    return function()
        local build_dir = lfs.currentdir()

        if stage ~= 1 and part ~= "llvm" then
            os.execute("rm -rf source/build-" .. part)

            local bin_dir = build_dir .. "/filesystem"
            options = options .. " -DLLVM_EXTERNAL_LIT=" ..
                build_dir .. "/source/build-llvm/utils/lit -DLLVM_ROOT=" .. bin_dir
        end

        local compiler_flags = "-I" .. build_dir .. "/filesystem-unwind/include"
        tools.build_cmake(
            (stage == 1 and ("-DLLVM_TARGETS_TO_BUILD=" .. arch .. " ") or "") ..
            "-DLLVM_TARGET_ARCH=" .. arch ..
            " -DLLVM_HOST_TRIPLE=" .. system.target ..
            " -DLLVM_DEFAULT_TARGET_TRIPLE=" .. system.target ..
            " -DCMAKE_ASM_COMPILER_TARGET=" .. system.target ..
            " -DCMAKE_C_COMPILER_TARGET=" .. system.target ..
            " -DCMAKE_CXX_COMPILER_TARGET=" .. system.target ..
            " -DLLVM_ENABLE_ZSTD=OFF -DLLVM_ENABLE_LIBXML2=OFF -DENABLE_LINKER_BUILD_ID=ON -DLLVM_INSTALL_BINUTILS_SYMLINKS=ON -DLLVM_INSTALL_UTILS=ON -DLLVM_INCLUDE_TESTS=OFF -DCOMPILER_RT_INCLUDE_TESTS=OFF -DLIBUNWIND_ENABLE_ASSERTIONS=OFF"
            .. options
            ,
            nil, part, compiler_flags, compiler_flags, "-L" .. build_dir .. "/filesystem-unwind/lib")()
    end
end

-- if stage ~= 1 then
--     variants = {
--         unwind = {
--             build = gen_build("runtimes", nil, { "libunwind" }),
--             pack = tools.pack_default(nil, "unwind")
--         },
--         libs = {
--             build = gen_build("runtimes", nil,
--                 { "compiler-rt", "libcxx", "libcxxabi", "libunwind" }),
--             pack = tools.pack_default(nil, "libs")
--         }
--     }
-- end

build = gen_build("llvm", { "clang" })

function pack()
    tools.pack_default()()

    lfs.link("clang", "filesystem/bin/cc", true)
    lfs.link("clang++", "filesystem/bin/c++", true)

    -- TODO: maybe remove this once linux is setup to build with clang?
    lfs.link("clang", "filesystem/bin/gcc", true)
    lfs.link("clang++", "filesystem/bin/g++", true)
end

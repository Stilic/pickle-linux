local system = require "system"
local tools = require "tools"
local lfs = require "lfs"

version = "21.1.6"
dependencies = { pkg "zstd" }
dev_dependencies = { pkg "cmake", pkg "python" }
sources = {
    { "source", "https://github.com/llvm/llvm-project/releases/download/llvmorg-" .. version .. "/llvm-project-" .. version .. ".src.tar.xz" }
}

local arch, triplet = "", ""
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

    triplet = system.architecture .. "-pc-linux-musl"
end
local function gen_build(projects, runtimes)
    local options = ""

    if projects then
        options = "-DLLVM_RELEASE_ENABLE_RUNTIMES="

        local l = #projects
        for i, project in ipairs(projects) do
            options = options .. project
            if i ~= l then
                options = options .. ";"
            end
        end

        options = options .. " "
    end

    if runtimes then
        options = options .. "-DLLVM_RELEASE_ENABLE_PROJECTS="

        local l = #runtimes
        for i, runtime in ipairs(runtimes) do
            options = options .. runtime
            if i ~= l then
                options = options .. ";"
            end
        end

        options = options .. " "
    end

    return tools.build_cmake(
        options ..
        (hostfs and ("-DLLVM_TARGETS_TO_BUILD=" .. arch .. " ") or "") .. "-DLLVM_TARGET_ARCH=" .. arch ..
        " -DLIBCXX_HAS_MUSL_LIBC=ON -DBOOTSTRAP_LIBCXX_HARDENING_MODE=fast -DLLVM_HOST_TRIPLE=" ..
        triplet ..
        " -DLLVM_DEFAULT_TARGET_TRIPLE=" ..
        triplet ..
        " -DCLANG_BOOTSTRAP_PASSTHROUGH=LLVM_TARGETS_TO_BUILD;LLVM_TARGET_ARCH;LLVM_DEFAULT_TARGET_TRIPLE;LIBCXX_HAS_MUSL_LIBC",
        nil, "clang/cmake/caches/Release", "llvm", "stage2")
end

local runtimes = { "compiler-rt", "libunwind", "libcxx", "libcxxabi" }
if not hostfs then
    variants = {
        libs = {
            build = gen_build(nil, runtimes),
            pack = tools.pack_default(nil, "libs")
        }
    }
    runtimes = nil
end

build = gen_build({ "clang", "clang-tools-extra", "lld" }, runtimes)

pack = tools.pack_default()

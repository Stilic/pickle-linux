local system = require "system"
local tools = require "tools"
local lfs = require "lfs"

version = "21.1.6"
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
local function gen_build(external_llvm, projects, runtimes)
    local projects_command = ""
    if projects then
        projects_command = " -DLLVM_ENABLE_PROJECTS="

        local l = #projects
        for i, project in ipairs(projects) do
            projects_command = projects_command .. project
            if i ~= l then
                projects_command = projects_command .. ";"
            end
        end

        projects_command = projects_command .. " "
    end

    local runtimes_command = ""
    if runtimes then
        runtimes_command = " -DLLVM_ENABLE_RUNTIMES="

        local l = #runtimes
        for i, runtime in ipairs(runtimes) do
            runtimes_command = runtimes_command .. runtime
            if i ~= l then
                runtimes_command = runtimes_command .. ";"
            end
        end

        runtimes_command = runtimes_command .. " "
    end

    return function()
        local external_command, targets = ""
        if external_llvm then
            local build_dir = lfs.currentdir()
            external_command = "-DLLVM_EXTERNAL_LIT=" ..
                build_dir .. "/source/build-llvm/utils/lit -DLLVM_ROOT=" .. build_dir .. "/filesystem "

            targets = {}
            for _, runtime in ipairs(runtimes) do
                table.insert(targets, "install-" .. runtime)
            end
        end
        tools.build_cmake(external_command ..
            "-DLLVM_TARGET_ARCH=" ..
            arch ..
            " -DLLVM_HOST_TRIPLE=" ..
            triplet ..
            " -DLLVM_DEFAULT_TARGET_TRIPLE= " ..
            triplet .. " -DLLVM_PARALLEL_LINK_JOBS=2 -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON -DLLVM_INCLUDE_TESTS=OFF " ..
            projects_command .. runtimes_command ..
            "-DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON -DCOMPILER_RT_BUILD_GWP_ASAN=OFF -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_USE_COMPILER_RT=ON -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=OFF -DLIBCXX_HAS_MUSL_LIBC=ON -DLIBCXX_HARDENING_MODE=fast -DLIBCXXABI_USE_LLVM_UNWINDER=ON -DLIBCXXABI_ENABLE_STATIC_UNWINDER=OFF -DLIBCXXABI_USE_COMPILER_RT=ON -DLLVM_INSTALL_UTILS=ON -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_LINK_LLVM_DYLIB=ON -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=ON -DCLANG_DEFAULT_RTLIB=compiler-rt -DCLANG_DEFAULT_UNWINDLIB=libunwind -DCLANG_DEFAULT_CXX_STDLIB=libc++ -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_LIBCXX=ON -DLIBUNWIND_ENABLE_ASSERTIONS=OFF -DLIBUNWIND_USE_COMPILER_RT=ON",
            nil, "llvm", targets)()
    end
end

build = gen_build(false, { "clang", "clang-tools-extra", "lld", "mlir" })

pack = tools.pack_default()

variants = {
    libs = {
        build = gen_build(true, { "clang" }, { "compiler-rt" })
    }
}

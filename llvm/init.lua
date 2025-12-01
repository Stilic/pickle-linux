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
local function gen_build(part, projects, runtimes)
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
        local external_command, compiler_flags = "", ""
        if part ~= "llvm" then
            local build_dir = lfs.currentdir()
            local bin_dir = build_dir .. "/filesystem"
            external_command = "-DLLVM_EXTERNAL_LIT=" ..
                build_dir .. "/source/build-llvm/utils/lit -DLLVM_ROOT=" .. bin_dir .. " "
            bin_dir = bin_dir .. "/bin/"
            external_command = external_command ..
                "-DCMAKE_C_COMPILER=" .. bin_dir .. "clang -DCMAKE_CXX_COMPILER=" .. bin_dir .. "clang++"

            -- https://wiki.debian.org/toolchain/BootstrapIssues#stdc-predef.h_not_found
            lfs.mkdir("include")
            os.execute("touch include/stdc-predef.h")
            compiler_flags = "-I" .. build_dir .. "/include"
        end
        tools.build_cmake(external_command ..
            "-DLLVM_TARGET_ARCH=" ..
            arch ..
            " -DLLVM_HOST_TRIPLE=" ..
            triplet ..
            " -DLLVM_DEFAULT_TARGET_TRIPLE=" ..
            triplet .. projects_command .. runtimes_command ..
            "-DCLANG_DEFAULT_CXX_STDLIB=libc++ -DCLANG_DEFAULT_RTLIB=compiler-rt -DCLANG_DEFAULT_UNWINDLIB=libunwind -DCLANG_ENABLE_ARCMT=OFF -DCLANG_ENABLE_LIBXML2=OFF -DCLANG_ENABLE_STATIC_ANALYZER=OFF -DCLANG_INCLUDE_TESTS=OFF -DCLANG_LINK_CLANG_DYLIB=ON -DCOMPILER_RT_BUILD_CTX_PROFILE=OFF -DCOMPILER_RT_BUILD_GWP_ASAN=OFF -DCOMPILER_RT_BUILD_LIBFUZZER=OFF -DCOMPILER_RT_BUILD_MEMPROF=OFF -DCOMPILER_RT_BUILD_PROFILE=OFF -DCOMPILER_RT_BUILD_SANITIZERS=OFF -DCOMPILER_RT_BUILD_XRAY=OFF -DCOMPILER_RT_DISABLE_AARCH64_FMV=OFF -DCOMPILER_RT_SCUDO_STANDALONE_BUILD_SHARED=OFF -DENABLE_LINKER_BUILD_ID=ON -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_ENABLE_LOCALIZATION=OFF -DLIBCXX_ENABLE_STATIC=OFF -DLIBCXX_ENABLE_UNICODE=OFF -DLIBCXX_HARDENING_MODE=fast -DLIBCXX_HAS_MUSL_LIBC=ON -DLIBCXX_INCLUDE_BENCHMARKS=OFF -DLIBCXX_INCLUDE_TESTS=OFF -DLIBCXX_INSTALL_MODULES=OFF -DLIBCXX_INSTALL_STATIC_LIBRARY=OFF -DLIBCXXABI_ENABLE_ASSERTIONS=OFF -DLIBCXXABI_ENABLE_STATIC_UNWINDER=OFF -DLIBCXXABI_INSTALL_STATIC_LIBRARY=OFF -DLIBCXXABI_USE_LLVM_UNWINDER=ON -DLIBUNWIND_ENABLE_ASSERTIONS=OFF -DLIBUNWIND_ENABLE_STATIC=OFF -DLLVM_APPEND_VC_REV=OFF -DLLVM_BUILD_LLVM_DYLIB=ON -DLLVM_BUILD_TELEMETRY=OFF -DLLVM_BUILD_TOOLS=OFF -DLLVM_BUILD_UTILS=OFF -DLLVM_ENABLE_BINDINGS=OFF -DLLVM_ENABLE_EH=ON -DLLVM_ENABLE_FFI=ON -DLLVM_ENABLE_LIBCXX=ON -DLLVM_ENABLE_LIBPFM=OFF -DLLVM_ENABLE_LIBXML2=OFF -DLLVM_ENABLE_LTO=OFF -DLLVM_ENABLE_OCAMLDOC=OFF -DLLVM_ENABLE_RTTI=ON -DLLVM_ENABLE_UNWIND_TABLES=OFF -DLLVM_ENABLE_ZLIB=FORCE_ON -DLLVM_ENABLE_ZSTD=FORCE_ON -DLLVM_INCLUDE_BENCHMARKS=OFF -DLLVM_INCLUDE_DOCS=OFF -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_TESTS=OFF -DLLVM_INSTALL_BINUTILS_SYMLINKS=ON -DLLVM_INSTALL_CCTOOLS_SYMLINKS=ON -DLLVM_INSTALL_UTILS=ON -DLLVM_LINK_LLVM_DYLIB=ON -DLLVM_OPTIMIZED_TABLEGEN=ON -DLLVM_PARALLEL_LINK_JOBS=1 -DLLVM_USE_SANITIZER=OFF -DLLVM_USE_SPLIT_DWARF=ON -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=ON",
            nil, part, compiler_flags, compiler_flags)()
    end
end

build = gen_build("llvm", { "clang", "clang-tools-extra", "lld", "mlir" })

pack = tools.pack_default()

variants = {
    libs = {
        build = gen_build("runtimes", nil, { "compiler-rt", "libunwind", "libcxx", "libcxxabi" }),
        pack = tools.pack_default()
    }
}

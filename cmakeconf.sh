cmake -S llvm -B build -G Ninja \
  -DLLVM_ENABLE_PROJECTS="clang" \
  -DDEFAULT_SYSROOT="/opt/riscv/riscv64-unknown-elf" \
  -DGCC_INSTALL_PREFIX="/opt/riscv" \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_ASSERTIONS="ON" \
  -DLLVM_USE_LINKER="lld" \
  -DLLVM_PARALLEL_LINK_JOBS=1 \
  -DLLVM_TARGETS_TO_BUILD="RISCV" \
  -DLLVM_DEFAULT_TARGET_TRIPLE="riscv64-unknown-elf"

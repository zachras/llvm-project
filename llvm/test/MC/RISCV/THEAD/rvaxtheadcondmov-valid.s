# RUN: llvm-mc %s -triple=riscv32 -mattr=+xtheadcondmov -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+xtheadcondmov < %s \
# RUN:     | llvm-objdump --mattr=+xtheadcondmov -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc %s -triple=riscv64 -mattr=+xtheadcondmov -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv64 -mattr=+xtheadcondmov < %s \
# RUN:     | llvm-objdump --mattr=+xtheadcondmov -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: th.mveqz t0, t1, t2
# CHECK-ASM: encoding: [0x8b,0x12,0x73,0x40]
th.mveqz t0, t1, t2

# CHECK-ASM-AND-OBJ: th.mvnez t0, t1, t2
# CHECK-ASM: encoding: [0x8b,0x12,0x73,0x42]
th.mvnez t0, t1, t2

# RUN: llvm-mc %s -triple=riscv32 -mattr=+xtheadmac -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+xtheadmac < %s \
# RUN:     | llvm-objdump --mattr=+xtheadmac -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: th.mula t0, t1, t2
# CHECK-ASM: encoding: [0x8b,0x12,0x73,0x20]
th.mula t0, t1, t2
# CHECK-ASM-AND-OBJ: th.mulah t0, t1, t2
# CHECK-ASM: encoding: [0x8b,0x12,0x73,0x28]
th.mulah t0, t1, t2

# CHECK-ASM-AND-OBJ: th.muls t0, t1, t2
# CHECK-ASM: encoding: [0x8b,0x12,0x73,0x22]
th.muls t0, t1, t2
# CHECK-ASM-AND-OBJ: th.mulsh t0, t1, t2
# CHECK-ASM: encoding: [0x8b,0x12,0x73,0x2a]
th.mulsh t0, t1, t2

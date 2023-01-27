# RUN: not llvm-mc -triple riscv32 -mattr=+xtheadcondmov < %s 2>&1 | FileCheck %s
# RUN: not llvm-mc -triple riscv64 -mattr=+xtheadcondmov < %s 2>&1 | FileCheck %s

# Too many operands
th.mveqz t0, t1, t2, t3 # CHECK: :[[@LINE]]:22: error: invalid operand for instruction
# Too few operands
th.mveqz t0, t1 # CHECK: :[[@LINE]]:1: error: too few operands for instruction

# Too many operands
th.mvnez t0, t1, t2, t3 # CHECK: :[[@LINE]]:22: error: invalid operand for instruction
# Too few operands
th.mvnez t0, t1 # CHECK: :[[@LINE]]:1: error: too few operands for instruction

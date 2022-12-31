# RUN: not llvm-mc -triple riscv64 -mattr=+m -mattr=+xtheadmac < %s 2>&1 | FileCheck %s

# Too many operands
th.mula t0, t1, t2, t3 # CHECK: :[[@LINE]]:21: error: invalid operand for instruction
# Too many operands
th.mulah t0, t1, t2, t3 # CHECK: :[[@LINE]]:22: error: invalid operand for instruction
# Too many operands
th.mulaw t0, t1, t2, t3 # CHECK: :[[@LINE]]:22: error: invalid operand for instruction
# Too few operands
th.mula t0, t1 # CHECK: :[[@LINE]]:1: error: too few operands for instruction
# Too few operands
th.mulah t0, t1 # CHECK: :[[@LINE]]:1: error: too few operands for instruction
# Too few operands
th.mulaw t0, t1 # CHECK: :[[@LINE]]:1: error: too few operands for instruction

# Too many operands
th.muls t0, t1, t2, t3 # CHECK: :[[@LINE]]:21: error: invalid operand for instruction
# Too many operands
th.mulsh t0, t1, t2, t3 # CHECK: :[[@LINE]]:22: error: invalid operand for instruction
# Too many operands
th.mulsw t0, t1, t2, t3 # CHECK: :[[@LINE]]:22: error: invalid operand for instruction
# Too few operands
th.muls t0, t1 # CHECK: :[[@LINE]]:1: error: too few operands for instruction
# Too few operands
th.mulsh t0, t1 # CHECK: :[[@LINE]]:1: error: too few operands for instruction
# Too few operands
th.mulsw t0, t1 # CHECK: :[[@LINE]]:1: error: too few operands for instruction

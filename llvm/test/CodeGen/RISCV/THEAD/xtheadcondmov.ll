; RUN: llc -march=riscv32 -mattr=+xtheadcondmov < %s | FileCheck %s -check-prefixes=ALL,RV32-TH-MVEQZ,RV32-TH-MVNEZ
; RUN: llc -march=riscv64 -mattr=+xtheadcondmov < %s | FileCheck %s -check-prefixes=ALL,RV64-TH-MVEQZ,RV64-TH-MVNEZ

; ALL-LABEL: mveqz1:

; ALL: th.mveqz a0, a1, a2
; ALL: ret
define i32 @mveqz1(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %cmp = icmp eq i32 %rs2, 0
  %rd = select i1 %cmp, i32 %rs1, i32 %rdcp

  ret i32 %rd
}

; ALL-LABEL: mvnez1:

; ALL: th.mvnez a0, a1, a2
; ALL: ret
define i32 @mvnez1(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %cmp = icmp ne i32 %rs2, 0
  %rd = select i1 %cmp, i32 %rs1, i32 %rdcp

  ret i32 %rd
}

; ALL-LABEL: mveqz2:

; RV32-TH-MVEQZ: or a4, a4, a5
; RV32-TH-MVEQZ: th.mveqz a0, a2, a4
; RV32-TH-MVEQZ: th.mveqz a1, a3, a4
; RV32-TH-MVEQZ: ret

; RV64-TH-MVEQZ: th.mveqz a0, a1, a2
; RV64-TH-MVEQZ: ret

define i64 @mveqz2(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp = icmp eq i64 %rs2, 0
  %rd = select i1 %cmp, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

; ALL-LABEL: mvnez2:

; RV32-TH-MVNEZ: or a4, a4, a5
; RV32-TH-MVNEZ: th.mvnez a0, a2, a4
; RV32-TH-MVNEZ: th.mvnez a1, a3, a4
; RV32-TH-MVNEZ: ret

; RV64-TH-MVNEZ: th.mvnez a0, a1, a2
; RV64-TH-MVNEZ: ret

define i64 @mvnez2(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp = icmp ne i64 %rs2, 0
  %rd = select i1 %cmp, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

; ALL-LABEL: generic.condition:

; RV64-TH-MVNEZ: slt     a2, a1, a2
; RV64-TH-MVNEZ: xori    a2, a2, 1
; RV64-TH-MVNEZ: th.mvnez a0, a1, a2
; RV64-TH-MVNEZ: ret

define i64 @generic.condition(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp = icmp sge i64 %rs1, %rs2
  %rd = select i1 %cmp, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

; ALL-LABEL: operations.before.condition

; RV64-TH-MVNEZ: add     a3, a1, a2
; RV64-TH-MVNEZ: sub     a2, a2, a3
; RV64-TH-MVNEZ: slli    a4, a2, 1
; RV64-TH-MVNEZ: add     a2, a4, a2
; RV64-TH-MVNEZ: neg     a2, a2
; RV64-TH-MVNEZ: sltu    a2, a3, a2
; RV64-TH-MVNEZ: th.mvnez        a0, a1, a2
; RV64-TH-MVNEZ: ret

define i64 @operations.before.condition(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %rs1.2 = add i64 %rs1, %rs2
  %rs2.2 = sub i64 %rs2, %rs1.2
  %rs2.3 = mul i64 %rs2.2, -3

  %cmp = icmp ult i64 %rs1.2, %rs2.3
  %rd = select i1 %cmp, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

; ALL-LABEL: mveqz.and.mvnez

; RV64-TH-MVNEZ: mv      a3, a0
; RV64-TH-MVNEZ: th.mveqz        a3, a1, a2
; RV64-TH-MVNEZ: th.mvnez        a0, a1, a3
; RV64-TH-MVNEZ: add     a0, a3, a0
; RV64-TH-MVNEZ: ret

define i64 @mveqz.and.mvnez(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp.1 = icmp eq i64 %rs2, 0
  %rd.1 = select i1 %cmp.1, i64 %rs1, i64 %rdcp

  %cmp.2 = icmp ne i64 %rd.1, 0 
  %rd.2 = select i1 %cmp.2, i64 %rs1, i64 %rdcp

  %rd.3 = add i64 %rd.1, %rd.2

  ret i64 %rd.3
}

; ALL-LABEL: complex.condition

; RV64-TH-MVNEZ: slti    a3, a1, 42
; RV64-TH-MVNEZ: slti    a4, a2, 42
; RV64-TH-MVNEZ: xori    a4, a4, 1
; RV64-TH-MVNEZ: and     a3, a3, a4
; RV64-TH-MVNEZ: xor     a2, a1, a2
; RV64-TH-MVNEZ: seqz    a2, a2
; RV64-TH-MVNEZ: or      a2, a3, a2
; RV64-TH-MVNEZ: th.mvnez        a0, a1, a2
; RV64-TH-MVNEZ: ret

define i64 @complex.condition(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp.1 = icmp slt i64 %rs1, 42
  %cmp.2 = icmp sge i64 %rs2, 42
  
  %cmp.1.and.cmp.2 = and i1 %cmp.1, %cmp.2
  
  %cmp.3 = icmp eq i64 %rs1, %rs2

  %cmp.1.and.cmp.2.or.cmp.3 = or i1 %cmp.1.and.cmp.2, %cmp.3

  %rd = select i1 %cmp.1.and.cmp.2.or.cmp.3, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

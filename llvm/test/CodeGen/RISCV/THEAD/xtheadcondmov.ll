; RUN: llc -march=riscv32 -mattr=+xtheadcondmov < %s | FileCheck %s -check-prefixes=ALL,RV32-TH-MVEQZ,RV32-TH-MVNEZ
; RUN: llc -march=riscv64 -mattr=+xtheadcondmov < %s | FileCheck %s -check-prefixes=ALL,RV64-TH-MVEQZ,RV64-TH-MVNEZ

;TODO: Add tests for cases where RV32 uses 64 bit values.

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

; ALL-LABEL: mveqz3:

; RV32-TH-MVEQZ: or a4, a4, a5
; RV32-TH-MVEQZ: th.mveqz a0, a2, a4
; RV32-TH-MVEQZ: th.mveqz a1, a3, a4
; RV32-TH-MVEQZ: ret

; RV64-TH-MVEQZ: th.mveqz a0, a1, a2
; RV64-TH-MVEQZ: ret

define i64 @mveqz3(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp = icmp eq i64 %rs2, 0
  %rd = select i1 %cmp, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

; ALL-LABEL: mvnez3:

; RV32-TH-MVNEZ: or a4, a4, a5
; RV32-TH-MVNEZ: th.mvnez a0, a2, a4
; RV32-TH-MVNEZ: th.mvnez a1, a3, a4
; RV32-TH-MVNEZ: ret

; RV64-TH-MVNEZ: th.mvnez a0, a1, a2
; RV64-TH-MVNEZ: ret

define i64 @mvnez3(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp = icmp ne i64 %rs2, 0
  %rd = select i1 %cmp, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

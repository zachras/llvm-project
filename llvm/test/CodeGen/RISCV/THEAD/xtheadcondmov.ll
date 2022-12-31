; RUN: llc -march=riscv32 < %s | FileCheck %s -check-prefixes=ALL,32bit-TH-MVEQZ,32bit-TH-MVNEZ
; RUN: llc -march=riscv64 < %s | FileCheck %s -check-prefixes=ALL,64bit-TH-MVEQZ,64bit-TH-MVNEZ

;TODO: Add tests for cases where RV32 uses 64 bit values.

declare i32 @f(i32 noundef) local_unnamed_addr

; ALL-LABEL: mveqz1:
; 32bit-TH-MVEQZ: th.mveqz a0, a1, a2
; 32bit-TH-MVEQZ: ret

; 64bit-TH-MVEQZ: th.mveqz a0, a1, a2
; 64bit-TH-MVEQZ: ret
define i32 @mveqz1(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %cmp = icmp eq i32 %rs2, 0
  %rd = select i1 %cmp, i32 %rs1, i32 %rdcp

  ret i32 %rd
}

; ALL-LABEL: mvnez1:
; 32bit-TH-MVNEZ: th.mvnez a0, a1, a2
; 32bit-TH-MVNEZ: ret

; 64bit-TH-MVNEZ: th.mvnez a0, a1, a2
; 64bit-TH-MVNEZ: ret
define i32 @mvnez1(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %cmp = icmp ne i32 %rs2, 0
  %rd = select i1 %cmp, i32 %rs1, i32 %rdcp

  ret i32 %rd
}

; ALL-LABEL: mveqz3:

; 32bit-TH-MVEQZ: or a4, a4, a5
; 32bit-TH-MVEQZ: th.mveqz a0, a2, a4
; 32bit-TH-MVEQZ: th.mveqz a1, a3, a4
; 32bit-TH-MVEQZ: ret

; 64bit-TH-MVEQZ: th.mveqz a0, a1, a2
; 64bit-TH-MVEQZ: ret

define i64 @mveqz3(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp = icmp eq i64 %rs2, 0
  %rd = select i1 %cmp, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

; ALL-LABEL: mvnez3:

; 32bit-TH-MVNEZ: or a4, a4, a5
; 32bit-TH-MVNEZ: th.mvnez a0, a2, a4
; 32bit-TH-MVNEZ: th.mvnez a1, a3, a4
; 32bit-TH-MVNEZ: ret

; 64bit-TH-MVNEZ: th.mvnez a0, a1, a2
; 64bit-TH-MVNEZ: ret

define i64 @mvnez3(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %cmp = icmp ne i64 %rs2, 0
  %rd = select i1 %cmp, i64 %rs1, i64 %rdcp

  ret i64 %rd
}

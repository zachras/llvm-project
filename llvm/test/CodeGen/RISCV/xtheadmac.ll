; RUN: llc -march=riscv32 -mattr=+m -mattr=+xtheadmac < %s | FileCheck %s -check-prefixes=ALL,RV32
; RUN: llc -march=riscv64 -mattr=+m -mattr=+xtheadmac < %s | FileCheck %s -check-prefixes=ALL,RV64

; ALL-LABEL: maddi16:

; ALL-RV: th.mulah a0, a1, a2
; ALL-RV: ret

define i16 @maddi16(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = add i16 %rdcp, %mul

  ret i16 %rd

}

; ALL-LABEL: maddi32:

; RV32: th.mula a0, a1, a2
; RV32: ret

; RV64: th.mulaw a0, a1, a2
; RV64: ret

define i32 @maddi32(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %mul = mul i32 %rs1, %rs2

  %rd = add i32 %rdcp, %mul

  ret i32 %rd

}

; ALL-LABEL: maddi64:

; TODO for RV32 

; RV64: th.mula a0, a1, a2
; RV64: ret

define i64 @maddi64(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %mul = mul i64 %rs1, %rs2

  %rd = add i64 %rdcp, %mul

  ret i64 %rd

}

; ALL-LABEL: msubi16:

; ALL-RV: th.mulsh a0, a1, a2
; ALL-RV: ret

define i16 @msubi16(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = sub i16 %rdcp, %mul

  ret i16 %rd

}

; ALL-LABEL: msubi32:

; RV32: th.muls a0, a1, a2
; RV32: ret

; RV64: th.mulsw a0, a1, a2
; RV64: ret

define i32 @msubi32(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %mul = mul i32 %rs1, %rs2

  %rd = sub i32 %rdcp, %mul

  ret i32 %rd

}

; ALL-LABEL: msubi64:

; TODO for RV32

; RV64: th.muls a0, a1, a2
; RV64: ret

define i64 @msubi64(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %mul = mul i64 %rs1, %rs2

  %rd = sub i64 %rdcp, %mul

  ret i64 %rd

}

; ALL-LABEL: maddi64.v2:

; TODO for RV32

; RV64: th.mula a0, a1, a2
; RV64: ret

define i64 @maddi64.v2(i64 %rdcp, i16 %rs1, i32 %rs2) {
entry:

  %rs1.2 = sext i16 %rs1 to i64
  %rs2.2 = sext i32 %rs2 to i64

  %mul = mul i64 %rs1.2, %rs2.2

  %rd = add i64 %rdcp, %mul

  ret i64 %rd

}

declare void @f(i32 %x)

; ALL-LABEL: mulah.despite.i32.usage:

; TODO for RV32

; RV64: th.mulah a0, a1, a2
; RV64: call f
; RV64: li a0, 1
; RV64: ret

define i1 @mulah.despite.i32.usage(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = add i16 %rdcp, %mul

  call void @f(i16 signext %rd)

  ret i1 true
}

declare i64 @fi64(...)
declare void @gi32(i32 noundef signext)

; ALL-LABEL: mulaw.from.i64.operands

; TODO for RV32

; RV64: addi    sp, sp, -32
; RV64: sd      ra, 24(sp)                      
; RV64: sd      s0, 16(sp)                      
; RV64: sd      s1, 8(sp)                       
; RV64: call    fi64
; RV64: mv      s0, a0
; RV64: call    fi64
; RV64: mv      s1, a0
; RV64: call    fi64
; RV64: th.mulaw        a0, s1, s0
; RV64: call    gi32
; RV64: li      a0, 1
; RV64: ld      ra, 24(sp)                      
; RV64: ld      s0, 16(sp)                      
; RV64: ld      s1, 8(sp)                       
; RV64: addi    sp, sp, 32
; RV64: ret

define i1 @mulaw.from.i64.operands() {
  %call = tail call i64 @fi64()
  %call1 = tail call i64 @fi64()
  %call2 = tail call i64 @fi64()
  %mul = mul nsw i64 %call1, %call
  %add = add nsw i64 %call2, %mul
  %conv = trunc i64 %add to i32
  tail call void @gi32(i32 noundef signext %conv)
  ret i1 1
}

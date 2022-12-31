; RUN: llc -march=riscv32 -mattr=+m -mattr=+xtheadmac < %s | FileCheck %s -check-prefixes=ALL,RV32
; RUN: llc -march=riscv64 -mattr=+m -mattr=+xtheadmac < %s | FileCheck %s -check-prefixes=ALL,RV64

; ALL-LABEL: madd.all.i16:

; ALL: th.mulah a0, a1, a2
; ALL: ret

define signext i16 @madd.all.i16(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = add i16 %rdcp, %mul

  ret i16 %rd

}

; ALL-LABEL: madd.all.i32:

; RV32: th.mula a0, a1, a2
; RV32: ret

; RV64: th.mulaw a0, a1, a2
; RV64: ret

define signext i32 @madd.all.i32(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %mul = mul i32 %rs1, %rs2

  %rd = add i32 %rdcp, %mul

  ret i32 %rd

}

; ALL-LABEL: madd.all.i64:

; RV32: mulhu	a6, a2, a4
; RV32: th.mula	a6, a2, a5
; RV32: th.mula	a6, a3, a4
; RV32: mv	a3, a0
; RV32: th.mula	a3, a2, a4
; RV32: sltu	a0, a3, a0
; RV32: add	a1, a1, a6
; RV32: add	a1, a1, a0
; RV32: mv	a0, a3
; RV32: ret

; RV64: th.mula a0, a1, a2
; RV64: ret

define signext i64 @madd.all.i64(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %mul = mul i64 %rs1, %rs2

  %rd = add i64 %rdcp, %mul

  ret i64 %rd

}

; ALL-LABEL: msub.all.i16:

; ALL: th.mulsh a0, a1, a2
; ALL: ret

define signext i16 @msub.all.i16(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = sub i16 %rdcp, %mul

  ret i16 %rd

}

; ALL-LABEL: msub.all.i32:

; RV32: th.muls a0, a1, a2
; RV32: ret

; RV64: th.mulsw a0, a1, a2
; RV64: ret

define signext i32 @msub.all.i32(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %mul = mul i32 %rs1, %rs2

  %rd = sub i32 %rdcp, %mul

  ret i32 %rd

}

; ALL-LABEL: msub.all.i64:

; RV32: mulhu	a6, a2, a4
; RV32: th.mula	a6, a2, a5
; RV32: th.mula	a6, a3, a4
; RV32: mul	a3, a2, a4
; RV32: sltu	a3, a0, a3
; RV32: th.muls	a0, a2, a4
; RV32: sub	a1, a1, a6
; RV32: sub	a1, a1, a3
; RV32: ret

; RV64: th.muls a0, a1, a2
; RV64: ret

define signext i64 @msub.all.i64(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %mul = mul i64 %rs1, %rs2

  %rd = sub i64 %rdcp, %mul

  ret i64 %rd

}

; ALL-LABEL: madd.i16.to.i32:

; ALL: th.mulah a0, a1, a2
; ALL: ret

define signext i32 @madd.i16.to.i32(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = add i16 %rdcp, %mul

  %rd.2 = sext i16 %rd to i32

  ret i32 %rd.2
}

; ALL-LABEL: madd.i16.to.i64:

; RV32: th.mulah	a0, a1, a2
; RV32: slli	a1, a0, 16
; RV32: srai	a1, a1, 31
; RV32: ret

; RV64: th.mulah a0, a1, a2
; RV64: ret

define signext i64 @madd.i16.to.i64(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = add i16 %rdcp, %mul

  %rd.2 = sext i16 %rd to i64

  ret i64 %rd.2
}

; ALL-LABEL: madd.i32.to.i16:

; ALL: th.mulah a0, a1, a2
; ALL: ret

define signext i16 @madd.i32.to.i16(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %mul = mul i32 %rs1, %rs2

  %rd = add i32 %rdcp, %mul

  %rd.2 = trunc i32 %rd to i16

  ret i16 %rd.2
}

; ALL-LABEL: madd.i32.to.i64:


; RV32: th.mula	a0, a1, a2
; RV32: srai	a1, a0, 31
; RV32: ret

; RV64: th.mulaw a0, a1, a2
; RV64: ret

define signext i64 @madd.i32.to.i64(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %mul = mul i32 %rs1, %rs2

  %rd = add i32 %rdcp, %mul

  %rd.2 = sext i32 %rd to i64

  ret i64 %rd.2
}

; ALL-LABEL: madd.i64.to.i16:

; RV32: th.mulah	a0, a2, a4
; RV32: ret

; RV64: th.mulah a0, a1, a2
; RV64: ret

define signext i16 @madd.i64.to.i16(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %mul = mul i64 %rs1, %rs2

  %rd = add i64 %rdcp, %mul

  %rd.2 = trunc i64 %rd to i16

  ret i16 %rd.2
}

; ALL-LABEL: madd.i64.to.i32:

; RV32: th.mula	a0, a2, a4
; RV32: ret

; RV64: th.mulaw a0, a1, a2
; RV64: ret

define signext i32 @madd.i64.to.i32(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %mul = mul i64 %rs1, %rs2

  %rd = add i64 %rdcp, %mul

  %rd.2 = trunc i64 %rd to i32

  ret i32 %rd.2
}

; ALL-LABEL: msub.i16.to.i32:

; ALL: th.mulsh a0, a1, a2
; ALL: ret

define signext i32 @msub.i16.to.i32(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = sub i16 %rdcp, %mul

  %rd.2 = sext i16 %rd to i32

  ret i32 %rd.2
}

; ALL-LABEL: msub.i16.to.i64:

; RV32: th.mulsh	a0, a1, a2
; RV32: slli	a1, a0, 16
; RV32: srai	a1, a1, 31
; RV32: ret

; RV64: th.mulsh a0, a1, a2
; RV64: ret

define signext i64 @msub.i16.to.i64(i16 %rdcp, i16 %rs1, i16 %rs2) {
entry:

  %mul = mul i16 %rs1, %rs2

  %rd = sub i16 %rdcp, %mul

  %rd.2 = sext i16 %rd to i64

  ret i64 %rd.2
}

; ALL-LABEL: msub.i32.to.i16:

; ALL: th.mulsh a0, a1, a2
; ALL: ret

define signext i16 @msub.i32.to.i16(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %mul = mul i32 %rs1, %rs2

  %rd = sub i32 %rdcp, %mul

  %rd.2 = trunc i32 %rd to i16

  ret i16 %rd.2
}

; ALL-LABEL: msub.i32.to.i64:


; RV32: th.muls	a0, a1, a2
; RV32: srai	a1, a0, 31
; RV32: ret

; RV64: th.mulsw a0, a1, a2
; RV64: ret

define signext i64 @msub.i32.to.i64(i32 %rdcp, i32 %rs1, i32 %rs2) {
entry:

  %mul = mul i32 %rs1, %rs2

  %rd = sub i32 %rdcp, %mul

  %rd.2 = sext i32 %rd to i64

  ret i64 %rd.2
}

; ALL-LABEL: msub.i64.to.i16:

; RV32: th.mulsh	a0, a2, a4
; RV32: ret

; RV64: th.mulsh a0, a1, a2
; RV64: ret

define signext i16 @msub.i64.to.i16(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %mul = mul i64 %rs1, %rs2

  %rd = sub i64 %rdcp, %mul

  %rd.2 = trunc i64 %rd to i16

  ret i16 %rd.2
}

; ALL-LABEL: msub.i64.to.i32:

; RV32: th.muls	a0, a2, a4
; RV32: ret

; RV64: th.mulsw a0, a1, a2
; RV64: ret

define signext i32 @msub.i64.to.i32(i64 %rdcp, i64 %rs1, i64 %rs2) {
entry:

  %mul = mul i64 %rs1, %rs2

  %rd = sub i64 %rdcp, %mul

  %rd.2 = trunc i64 %rd to i32

  ret i32 %rd.2
}

; ALL-LABEL: madd.all.type.mix.to.i64:


; RV32: mulh	a5, a2, a3
; RV32: mv	a4, a0
; RV32: th.mula	a4, a2, a3
; RV32: sltu	a0, a4, a0
; RV32: add	a1, a1, a5
; RV32: add	a1, a1, a0
; RV32: mv	a0, a4
; RV32: ret

; RV64: th.mula a0, a1, a2
; RV64: ret

define signext i64 @madd.all.type.mix.to.i64(i64 %rdcp, i16 signext %rs1, i32 signext %rs2) {
entry:

  %rs1.2 = sext i16 %rs1 to i64
  %rs2.2 = sext i32 %rs2 to i64

  %mul = mul i64 %rs1.2, %rs2.2

  %rd = add i64 %rdcp, %mul

  ret i64 %rd

}

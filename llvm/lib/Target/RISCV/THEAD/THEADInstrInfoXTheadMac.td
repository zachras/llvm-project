//===----------------------------------------------------------------------===//
// Classes to determine mula or muls flavour.
//===----------------------------------------------------------------------===//

class MacNBitPatFrag<SDPatternOperator IRSDOperator, code predicate> 
      : PatFrag<(ops node:$rd, node:$rs1, node:$rs2),
                (XLenVT (IRSDOperator node:$rd, (mul node:$rs1, node:$rs2))),
                predicate> {
  
	assert !or(!eq(IRSDOperator, add),
						 !eq(IRSDOperator, sub)),
						 "MacNBitPatFrag accepts only \"add\" or \"sub\" SDPatternOperator values.";

  assert !or(!eq(predicate, "\n  return hasAllWUsers(Node);\n"),
						 !eq(predicate, "\n  return hasAllHUsers(Node);\n")),
						 "MacNBitPatFrag accepts only word or half word operation result usage predicate check.";

}

class MacWordPatFrag<SDPatternOperator IRSDOperator> : MacNBitPatFrag<IRSDOperator, [{
  return hasAllWUsers(Node);
}]>;

class MacHalfWordPatFrag<SDPatternOperator IRSDOperator> : MacNBitPatFrag<IRSDOperator, [{
  return hasAllHUsers(Node);
}]>; 

//===----------------------------------------------------------------------===//
// A pattern class records of which specify 3 input operands. The difference
// between the initial and the resultant DAG is only the DAG operator.
//===----------------------------------------------------------------------===//

class PatGprGprWithRd<SDPatternOperator IRSDOperator, RVInst RVInstruction>
    : Pat<(IRSDOperator GPR:$rd, GPR:$rs1, GPR:$rs2), (RVInstruction GPR:$rd, GPR:$rs1, GPR:$rs2)> {
	
	assert !isa<RdRdRs2InstructionFormat>(RVInstruction),
						 "PatGprGprWithRd accepts only RdRdRs2InstructionFormat RVInst values.";

}

//===----------------------------------------------------------------------===//
// XTheadMac Instruction records.
//===----------------------------------------------------------------------===//

let Predicates = [HasExtXTheadMac] in {

def TH_MULA : RdRdRs2InstructionFormat<0b0010000, 0b001, "th.mula", "$rd, $rs1, $rs2">;

def TH_MULAH : RdRdRs2InstructionFormat<0b0010100, 0b001, "th.mulah", "$rd, $rs1, $rs2">;

let Predicates = [IsRV64, HasExtXTheadMac] in
def TH_MULAW : RdRdRs2InstructionFormat<0b0010010, 0b001, "th.mulaw", "$rd, $rs1, $rs2">;

def TH_MULS : RdRdRs2InstructionFormat<0b0010001, 0b001, "th.muls", "$rd, $rs1, $rs2">;
def TH_MULSH : RdRdRs2InstructionFormat<0b0010101, 0b001, "th.mulsh", "$rd, $rs1, $rs2">;

let Predicates = [IsRV64, HasExtXTheadMac] in
def TH_MULSW : RdRdRs2InstructionFormat<0b0010011, 0b001, "th.mulsw", "$rd, $rs1, $rs2">;

//===----------------------------------------------------------------------===//
// XTheadMac Instruction patterns.
//===----------------------------------------------------------------------===//

def : PatGprGprWithRd<MacHalfWordPatFrag<add>, TH_MULAH>;

let Predicates = [IsRV64, HasExtXTheadMac] in
def : PatGprGprWithRd<MacWordPatFrag<add>, TH_MULAW>;

def : Pat<(add GPR:$rd, (mul GPR:$rs1, GPR:$rs2)),
          (TH_MULA GPR:$rd, GPR:$rs1, GPR:$rs2)>;

def : PatGprGprWithRd<MacHalfWordPatFrag<sub>, TH_MULSH>;

let Predicates = [IsRV64, HasExtXTheadMac] in
def : PatGprGprWithRd<MacWordPatFrag<sub>, TH_MULSW>;

def : Pat<(sub GPR:$rd, (mul GPR:$rs1, GPR:$rs2)),
          (TH_MULS GPR:$rd, GPR:$rs1, GPR:$rs2)>;

}

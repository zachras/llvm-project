//===----------------------------------------------------------------------===//
// Classes to determine mula or muls flavour.
//===----------------------------------------------------------------------===//

class MacNBitPatFrag<SDPatternOperator IRSDOperator, code predicate> 
      : PatFrag<(ops node:$rd, node:$rs1, node:$rs2),
                (XLenVT (IRSDOperator node:$rd, (mul node:$rs1, node:$rs2))),
                predicate> {
  assert !or(!eq(IRSDOperator, add), !eq(IRSDOperator, sub)), "MacNBitPatFrag accepts only \"add\" or \"sub\" SDPatternOperator values.";
//TODO: assert for predicate?
}

class MacWordPatFrag<SDPatternOperator IRSDOperator> : MacNBitPatFrag<IRSDOperator, [{
  return hasAllWUsers(Node) && !hasAllHUsers(Node);
}]>;

class MacHalfWordPatFrag<SDPatternOperator IRSDOperator> : MacNBitPatFrag<IRSDOperator, [{
  return hasAllHUsers(Node);
}]>; 

//===----------------------------------------------------------------------===//
// A pattern class records of which specify 3 operands. The difference between
// the initial and the resultant DAG is only the DAG operator.
//===----------------------------------------------------------------------===//

class PatGprGprWithRd<SDPatternOperator IRSDOperator, RVInst RVInstruction>
    : Pat<(IRSDOperator GPR:$rd, GPR:$rs1, GPR:$rs2), (RVInstruction GPR:$rd, GPR:$rs1, GPR:$rs2)> {
  //TODO Add assert for rdcp=rd?
}

//===----------------------------------------------------------------------===//
// xtheadmac Instruction records.
//===----------------------------------------------------------------------===//

let Predicates = [HasExtxtheadmac] in {

def TH_MULA : THEADRFormatInstruction<0b0010000, 0b001, "th.mula", "$rd, $rs1, $rs2">;
							//Sched<[WriteMULA, ReadMULA, ReadMULA, ReadMULA]>;

def TH_MULAH : THEADRFormatInstruction<0b0010100, 0b001, "th.mulah", "$rd, $rs1, $rs2">;
 	 	 					 //Sched<[WriteMULAH, ReadMULAH, ReadMULAH, ReadMULAH]>;

let Predicates = [IsRV64, HasExtxtheadmac] in
def TH_MULAW : THEADRFormatInstruction<0b0010010, 0b001, "th.mulaw", "$rd, $rs1, $rs2">;
							 //Sched<[WriteMULAW, ReadMULAW, ReadMULAW, ReadMULAW]>;

def TH_MULS : THEADRFormatInstruction<0b0010001, 0b001, "th.muls", "$rd, $rs1, $rs2">;
def TH_MULSH : THEADRFormatInstruction<0b0010101, 0b001, "th.mulsh", "$rd, $rs1, $rs2">;

let Predicates = [IsRV64, HasExtxtheadmac] in
def TH_MULSW : THEADRFormatInstruction<0b0010011, 0b001, "th.mulsw", "$rd, $rs1, $rs2">;

//===----------------------------------------------------------------------===//
// xtheadmac Instruction patterns.
//===----------------------------------------------------------------------===//

def : PatGprGprWithRd<MacHalfWordPatFrag<add>, TH_MULAH>;

let Predicates = [IsRV64, HasExtxtheadmac] in
def : PatGprGprWithRd<MacWordPatFrag<add>, TH_MULAW>;

def : Pat<(add GPR:$rd, (mul GPR:$rs1, GPR:$rs2)),
          (TH_MULA GPR:$rd, GPR:$rs1, GPR:$rs2)>;

def : PatGprGprWithRd<MacHalfWordPatFrag<sub>, TH_MULSH>;

let Predicates = [IsRV64, HasExtxtheadmac] in
def : PatGprGprWithRd<MacWordPatFrag<sub>, TH_MULSW>;

def : Pat<(sub GPR:$rd, (mul GPR:$rs1, GPR:$rs2)),
          (TH_MULS GPR:$rd, GPR:$rs1, GPR:$rs2)>;

}

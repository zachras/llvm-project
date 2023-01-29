let Predicates = [HasExtXTheadCondMov] in {

//===----------------------------------------------------------------------===//
// XTheadCondMov Instruction records.
//===----------------------------------------------------------------------===//

def TH_MVEQZ : RdRdRs2InstructionFormat<0b0100000, 0b001, "th.mveqz", "$rd, $rs1, $rs2">;
def TH_MVNEZ : RdRdRs2InstructionFormat<0b0100001, 0b001, "th.mvnez", "$rd, $rs1, $rs2">;

//===----------------------------------------------------------------------===//
// XTheadCondMov Instruction patterns.
//===----------------------------------------------------------------------===//

def : Pat<(select (XLenVT (seteq GPR:$rs2, 0)), GPR:$rs1, GPR:$rdcp),
          (TH_MVEQZ GPR:$rdcp, GPR:$rs1, GPR:$rs2)>;

def : Pat<(select (XLenVT (setne GPR:$rs2, 0)), GPR:$rs1, GPR:$rdcp),
          (TH_MVNEZ GPR:$rdcp, GPR:$rs1, GPR:$rs2)>;

def : Pat<(select GPR:$rs2, GPR:$rs1, GPR:$rdcp),
          (TH_MVNEZ GPR:$rdcp, GPR:$rs1, GPR:$rs2)>;

}

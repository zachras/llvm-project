//===----------------------------------------------------------------------===//
// T-HEAD subtarget features and instruction predicates.
//===----------------------------------------------------------------------===//

def FeatureExtxtheadcondmov
    : SubtargetFeature<"xtheadcondmov", "HasExtxtheadcondmov", "true",
                       "'xtheadcondmov' (T-Head Conditional Move Instructions)">;
def HasExtxtheadcondmov : Predicate<"Subtarget->hasExtxtheadcondmov()">,
                           AssemblerPredicate<(all_of FeatureExtxtheadcondmov),
                           "'xtheadcondmov' (T-Head Conditional Move Instructions)">;

def FeatureExtxtheadmac
    : SubtargetFeature<"xtheadmac", "HasExtxtheadmac", "true",
                       "'xtheadmac' (T-Head Multiply-Add Instructions)">;
def HasExtxtheadmac : Predicate<"Subtarget->hasExtxtheadmac()">,
                           AssemblerPredicate<(all_of FeatureExtxtheadmac),
                           "'xtheadmac' (T-Head Multiply-Add Instructions)">;

//===----------------------------------------------------------------------===//
// T-HEAD common records & classes.
//===----------------------------------------------------------------------===//

def OPC_THEAD : RISCVOpcode<"THEAD", 0b0001011>;

class THEADRFormatInstruction<bits<7> funct7, bits<3> funct3, string opcodestr, string argstr>
      : RVInstR<funct7, funct3, OPC_THEAD, (outs GPR:$rd), (ins GPR:$rdcp , GPR:$rs1, GPR:$rs2), opcodestr, argstr> {
  let Constraints = "$rdcp = $rd";
}

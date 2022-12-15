def OPC_THEAD : RISCVOpcode<"THEAD", 0b0001011>;

//===----------------------------------------------------------------------===//
// T-HEAD Instruction Formats.
//===----------------------------------------------------------------------===//

class THEADRFormatInstruction<bits<7> funct7, bits<3> funct3, string opcodestr, string argstr>
      : RVInstR<funct7, funct3, OPC_THEAD, (outs GPR:$rd), (ins GPR:$rdcp , GPR:$rs1, GPR:$rs2), opcodestr, argstr> {
  let Constraints = "$rdcp = $rd";
}


//===----------------------------------------------------------------------===//
// T-HEAD subtarget features and instruction predicates.
//===----------------------------------------------------------------------===//

def FeatureExtxtheadcondmov
    : SubtargetFeature<"xtheadcondmov", "HasExtxtheadcondmov", "true",
                       "'xtheadcondmov' (T-Head Conditional Move Instructions)">;
def HasExtxtheadcondmov : Predicate<"Subtarget->hasExtxtheadcondmov()">,
                           AssemblerPredicate<(all_of FeatureExtxtheadcondmov),
                           "'xtheadcondmov' (T-Head Conditional Move Instructions)">;

def FeatureExtXTheadMac
    : SubtargetFeature<"xtheadmac", "HasExtXTheadMac", "true",
                       "'XTheadMac' (T-Head Multiply-Accumulate Instructions)">;
def HasExtXTheadMac : Predicate<"Subtarget->hasExtXTheadMac()">,
                           AssemblerPredicate<(all_of FeatureExtXTheadMac),
                           "'XTheadMac' (T-Head Multiply-Accumulate Instructions)">;

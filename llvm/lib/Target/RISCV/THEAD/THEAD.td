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

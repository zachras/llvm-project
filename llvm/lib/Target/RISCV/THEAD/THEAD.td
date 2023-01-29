//===----------------------------------------------------------------------===//
// T-HEAD subtarget features and instruction predicates.
//===----------------------------------------------------------------------===//

def FeatureExtXTheadCondMov
    : SubtargetFeature<"xtheadcondmov", "HasExtXTheadCondMov", "true",
                       "'XTheadCondMov' (T-Head Conditional Move Instructions)">;
def HasExtXTheadCondMov : Predicate<"Subtarget->hasExtXTheadCondMov()">,
                           AssemblerPredicate<(all_of FeatureExtXTheadCondMov),
                           "'XTheadCondMov' (T-Head Conditional Move Instructions)">;

def FeatureExtxtheadmac
    : SubtargetFeature<"xtheadmac", "HasExtxtheadmac", "true",
                       "'xtheadmac' (T-Head Multiply-Add Instructions)">;
def HasExtxtheadmac : Predicate<"Subtarget->hasExtxtheadmac()">,
                           AssemblerPredicate<(all_of FeatureExtxtheadmac),
                           "'xtheadmac' (T-Head Multiply-Add Instructions)">;

//===----------------------------------------------------------------------===//
// T-HEAD subtarget features and instruction predicates.
//===----------------------------------------------------------------------===//

def FeatureExtXTheadCondMov
    : SubtargetFeature<"xtheadcondmov", "HasExtXTheadCondMov", "true",
                       "'XTheadCondMov' (T-Head Conditional Move Instructions)">;
def HasExtXTheadCondMov : Predicate<"Subtarget->hasExtXTheadCondMov()">,
                          AssemblerPredicate<(all_of FeatureExtXTheadCondMov),
                          "'XTheadCondMov' (T-Head Conditional Move Instructions)">;

def FeatureExtXTheadMac
    : SubtargetFeature<"xtheadmac", "HasExtXTheadMac", "true",
                       "'XTheadMac' (T-Head Multiply-Accumulate Instructions)">;
def HasExtXTheadMac : Predicate<"Subtarget->hasExtXTheadMac()">,
                      AssemblerPredicate<(all_of FeatureExtXTheadMac),
                      "'XTheadMac' (T-Head Multiply-Accumulate Instructions)">;

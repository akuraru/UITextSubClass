//
// Created by azu on 2013/09/30.
//


#import "UITextSubClassHelper.h"


@implementation UITextSubClassHelper {

}
static BOOL _alwaysUseMainBundle = NO;
static NSBundle *_userDefineBundle;

+ (void)setAlwaysUseMainBundle:(BOOL) alwaysUseMainBundle {
    _alwaysUseMainBundle = alwaysUseMainBundle;
}

+ (void)setBundle:(NSBundle *) bundle {
    _userDefineBundle = bundle;
}

+ (NSBundle *)bundle {
    NSBundle *bundle;
    if (_userDefineBundle != nil) {
        bundle = _userDefineBundle;
    } else if (_alwaysUseMainBundle) {
        bundle = [NSBundle mainBundle];
    } else {
        NSURL *coreBundleURl = [[NSBundle bundleForClass:[self class]] URLForResource:@"UITextSubClassLocalize" withExtension:@"bundle"];
        if (coreBundleURl) {
            bundle = [NSBundle bundleWithURL:coreBundleURl];
        } else {
            bundle = [NSBundle bundleForClass:[self class]];
        }
    }
    return bundle;
}
@end
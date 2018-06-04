//
// Created by azu on 2013/09/30.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const UITextSubClassLocalize;

@interface UITextSubClassHelper : NSObject
+ (NSBundle *)bundle;

// if you want to use custom bundle.
+ (void)setBundle:(NSBundle *) bundle;

// if you want to use mainBundle.
+ (void)setAlwaysUseMainBundle:(BOOL) alwaysUseMainBundle;
@end

NS_ASSUME_NONNULL_END

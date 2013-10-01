//
//  UITextFieldWithDecimalPad.m
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/09/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import "UITextFieldWithDecimalPad.h"

@implementation UITextFieldWithDecimalPad

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.keyboardType = UIKeyboardTypeDecimalPad;
        self.menuHidden = YES;
    }
    return self;
}
- (CGFloat)value {
    return [self format:[self.text floatValue]];
}
- (void)setValue:(CGFloat)value {
    super.text = [@([self format:value]) stringValue];
}
- (CGFloat)format:(CGFloat)value {
    NSInteger num = pow(10, self.significantFigures);
    return ((NSInteger)(value * num))/(CGFloat)num;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.menuHidden) {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        if (menuController) {
            [UIMenuController sharedMenuController].menuVisible = NO;
        }
        return NO;
    } else {
        return YES;
    }
}

@end

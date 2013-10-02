//
//  UITextFieldWithNumberPad.m
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/09/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import "UITextFieldWithNumberPad.h"

@implementation UITextFieldWithNumberPad

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.menuHidden = YES;
        [self addTarget:self action:@selector(didChangeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}
- (void)didChangeText:(id)sender {
    self.value = self.text.integerValue;
}
- (NSInteger)value {
    return [self.text integerValue];
}
- (void)setValue:(NSInteger)value {
    super.text = [@(value) stringValue];
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

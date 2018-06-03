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
        [self addTarget:self action:@selector(didChangeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)didChangeText:(id)sender {
    NSString *phoneNumberRegex = @"^([1-9]\\d*|0)?(\\.(\\d+)?)?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];
    if ([predicate evaluateWithObject:self.text] == NO) {
        self.value = self.text.floatValue;
    }
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
        return NO;
    } else {
        return YES;
    }
}

- (NSUndoManager *)undoManager {
    return nil;
}

@end

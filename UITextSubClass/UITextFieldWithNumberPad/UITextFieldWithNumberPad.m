//
//  UITextFieldWithNumberPad.m
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/09/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import "UITextFieldWithNumberPad.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UITextFieldWithNumberPad

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype _Nullable)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.menuHidden = YES;
    [self addTarget:self action:@selector(didChangeText:) forControlEvents:UIControlEventEditingChanged];
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

- (BOOL)canPerformAction:(SEL)action withSender:(id _Nullable)sender {
    if (self.menuHidden) {
        return NO;
    } else {
        return [super canPerformAction:action withSender:sender];
    }
}

- (NSUndoManager * _Nullable)undoManager {
    return nil;
}

@end

NS_ASSUME_NONNULL_END

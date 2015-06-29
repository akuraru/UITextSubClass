//
//  UITextFieldWithDecimalPad.h
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/09/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextFieldWithDecimalPad : UITextField

@property (nonatomic) BOOL menuHidden;
@property (nonatomic) NSUInteger significantFigures;

- (CGFloat)value;
- (void)setValue:(CGFloat)value;

@end

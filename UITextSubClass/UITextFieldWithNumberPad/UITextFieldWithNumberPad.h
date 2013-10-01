//
//  UITextFieldWithNumberPad.h
//  MotherChildHandbook
//
//  Created by P.I.akura on 2013/09/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITextFieldWithNumberPad : UITextField

@property (nonatomic) BOOL menuHidden;

- (NSInteger)value;
- (void)setValue:(NSInteger)value;

@end

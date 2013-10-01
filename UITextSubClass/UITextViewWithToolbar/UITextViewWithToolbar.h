//
//  UITextViewWithToolbar.h
//  diseases
//
//  Created by azu on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



@interface UITextViewWithToolbar : UITextView

#pragma mark - user defined runtime attributes

@property(nonatomic, strong) NSString *placeholderText;
@property(nonatomic, strong) UIColor *placeholderColor;
@property(nonatomic, strong) UILabel *placeholder;

// Those Property would only work with Storyboard - iOS5
@property(nonatomic, strong) UIColor *borderColor; // Color
@property(nonatomic, strong) UIColor *shadowColor; // Color
@property(nonatomic, strong) NSString *shadowOpacity; // Number (available decimal) eg. 1 or 0.5
@property(nonatomic, strong) NSString *borderWidth; // Number (available decimal) eg. 1 or 0.5
@property(nonatomic, strong) NSString *cornerRadius; // Number (available decimal) eg. 1 or 0.5
@property(nonatomic, strong) NSString *shadowRadius; // Number (available decimal) eg. 1 or 0.5
@property(nonatomic, strong) NSValue *shadowOffset; // CGSize
@end

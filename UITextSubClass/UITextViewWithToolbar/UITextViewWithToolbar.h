//
//  UITextViewWithToolbar.h
//  diseases
//
//  Created by azu on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//



#import "UITextViewWithPlaceholder.h"

@interface UITextViewWithToolbar : UITextViewWithPlaceholder
#pragma mark - user defined runtime attributes
@property(nonatomic, strong) UILabel *placeholder;
@end

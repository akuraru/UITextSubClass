//
//  UITextViewWithToolbar.m
//
//  Created by azu on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITextViewWithToolbar.h"
#import "UITextSubClassHelper.h"

@implementation UITextViewWithToolbar {
}
#pragma mark - toolbar

- (void)done {
    [self resignFirstResponder];
}

- (UIView *)inputAccessoryView {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.translucent = YES;
    [toolbar sizeToFit];

    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
        target:nil action:nil];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] init];
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.title = NSLocalizedStringFromTableInBundle(@"Done", UITextSubClassLocalize, [UITextSubClassHelper bundle], @"Done");
    doneButton.target = self;
    doneButton.action = @selector(done);
    [toolbar setItems:@[centerSpace, doneButton]];
    return toolbar;
}
@end

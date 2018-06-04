//
//  Created by azu on 12/11/20.
//


#import "UITextFieldWithToolbar.h"
#import "UITextSubClassHelper.h"

NS_ASSUME_NONNULL_BEGIN

@implementation UITextFieldWithToolbar

- (BOOL)becomeFirstResponder {
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [super resignFirstResponder];
}

- (UIView * _Nullable)inputAccessoryView {
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
    doneButton.action = @selector(resignFirstResponder);
    [toolbar setItems:@[centerSpace, doneButton]];
    return toolbar;
}

@end

NS_ASSUME_NONNULL_END

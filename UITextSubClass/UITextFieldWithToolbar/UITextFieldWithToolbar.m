//
//  Created by azu on 12/11/20.
//


#import "UITextFieldWithToolbar.h"
#import "UITextSubClassHelper.h"


@implementation UITextFieldWithToolbar {

}

- (BOOL)becomeFirstResponder {
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [super resignFirstResponder];
}

- (UIView *)inputAccessoryView {
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
        target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] init];
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.title = NSLocalizedStringFromTableInBundle(@"Done", nil, [UITextSubClassHelper bundle], @"Done");
    doneButton.target = self;
    doneButton.action = @selector(resignFirstResponder);
    [keyboardDoneButtonView setItems:@[centerSpace, doneButton]];

    return keyboardDoneButtonView;
}
@end
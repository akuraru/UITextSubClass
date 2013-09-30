//
//  Created by azu on 12/11/20.
//


#import "UITextFieldWithToolbar.h"


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
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
        target:nil action:nil];
    UIBarButtonItem *doneButton;
    doneButton = [[UIBarButtonItem alloc] init];
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.tintColor = nil;
    doneButton.title = NSLocalizedString(@"Done", @"Done");
    doneButton.target = self;
    doneButton.action = @selector(resignFirstResponder);
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:centerSpace, doneButton, nil]];

    return keyboardDoneButtonView;
}
@end
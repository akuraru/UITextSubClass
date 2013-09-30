//
//  Created by azu on 12/07/06.
//


#import "UITextFieldWithPicker.h"
#import "UITextFieldWithPickerProtocol.h"
#import "UITextSubClassHelper.h"


@implementation UITextFieldWithPicker {
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *) pickerView {
    // Components is single
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *) pickerView numberOfRowsInComponent:(NSInteger) component; {
    return [self.dataSource count];
}

- (NSString *)pickerView:(UIPickerView *) picker titleForRow:(NSInteger) row forComponent:(NSInteger) component {
    return [self.dataSource objectAtIndex:(NSUInteger)row];
}


- (id)initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    return self;

}

- (UIView *)inputView {
    return self.pickerView;
}

- (NSString *)selectedValue {
    NSInteger selected = [self.pickerView selectedRowInComponent:0];
    return [self.dataSource objectAtIndex:(NSUInteger)selected];
}

- (void)donePicker {
    if ([self selectedValue]) {
        self.text = [self selectedValue];
        if ([self.myDelegate respondsToSelector:@selector(savePickerView:)]) {
            [self.myDelegate savePickerView:self.pickerView];
        }
    }
    [self resignFirstResponder];
}

- (void)cancelDatePicker {
    [self resignFirstResponder];
}

- (UIView *)inputAccessoryView {
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    [keyboardDoneButtonView sizeToFit];

    UIBarButtonItem *cancelButton;
    cancelButton = [[UIBarButtonItem alloc] init];
    cancelButton.style = UIBarButtonItemStyleBordered;
    cancelButton.title = NSLocalizedStringFromTableInBundle(@"Cancel", nil, [UITextSubClassHelper bundle], @"Cancel");
    cancelButton.target = self;
    cancelButton.action = @selector(cancelDatePicker);
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
        target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] init];
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.title = NSLocalizedStringFromTableInBundle(@"Done", nil, [UITextSubClassHelper bundle], @"Done");
    doneButton.target = self;
    doneButton.action = @selector(donePicker);
    [keyboardDoneButtonView setItems:@[cancelButton, centerSpace, doneButton]];
    return keyboardDoneButtonView;
}

@end
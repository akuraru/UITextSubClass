//
//  Created by azu on 12/07/06.
//


#import "UITextFieldWithPicker.h"
#import "UITextFieldWithPickerProtocol.h"


@implementation UITextFieldWithPicker {

@private
    UIPickerView *pickerView_;
    NSArray *dataSource_;
}

@synthesize pickerView = pickerView_;
@synthesize dataSource = dataSource_;
@synthesize delegate = delegate_;


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // コンポーネント(ぐるぐる回る列)は2つ
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {
    return [self.dataSource count];
}

- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.dataSource objectAtIndex:row];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self){
        return nil;
    }

    // ピッカーの作成
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
    return [self.dataSource objectAtIndex:selected];
}

- (void)donePicker {
    if ([self selectedValue]){
        self.text = [self selectedValue];
        if ([self.delegate respondsToSelector:@selector(savePickerView:)]){
            [self.delegate savePickerView:self.pickerView];
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
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];

    UIBarButtonItem *cancelButton;
    cancelButton = [[UIBarButtonItem alloc] init];
    cancelButton.style = UIBarButtonItemStyleBordered;
    cancelButton.title = NSLocalizedString(@"Cancel", @"Cancel");
    cancelButton.target = self;
    cancelButton.action = @selector(cancelDatePicker);
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
        target:nil action:nil];
    UIBarButtonItem *doneButton;
    doneButton = [[UIBarButtonItem alloc] init];
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.title = NSLocalizedString(@"Save", @"Save");
    doneButton.target = self;
    doneButton.action = @selector(donePicker);
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:cancelButton, centerSpace, doneButton, nil]];
    return keyboardDoneButtonView;
}

@end
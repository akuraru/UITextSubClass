//
//  Created by azu on 12/07/06.
//


#import "UITextFieldWithPicker.h"
#import "UITextFieldWithPickerProtocol.h"

@implementation UITextFieldWithPicker


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

- (UIView *)inputView {
    return self.pickerView;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        [(UIPickerView *)_pickerView setDelegate:self];
        [(UIPickerView *)_pickerView setShowsSelectionIndicator:YES];
    }
    return _pickerView;
}

- (NSString *)selectedValue {
    NSInteger selected = [self.pickerView selectedRowInComponent:0];
    return [self.dataSource objectAtIndex:(NSUInteger)selected];
}

- (void)donePicker {
    if ([self selectedValue]) {
        self.text = [self selectedValue];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
        if ([self.myDelegate respondsToSelector:@selector(savePickerView:)]) {
            [self.myDelegate savePickerView:self.pickerView];
        }
#pragma clang diagnostic pop
        if ([self.myDelegate respondsToSelector:@selector(savePickerFrom:)]) {
            [self.myDelegate savePickerFrom:self];
        }
    }
    [super dismissPickerView];
}

@end
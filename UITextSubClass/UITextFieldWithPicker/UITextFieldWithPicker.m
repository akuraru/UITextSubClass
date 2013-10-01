//
//  Created by azu on 12/07/06.
//


#import "UITextFieldWithPicker.h"
#import "UITextFieldWithPickerProtocol.h"
#import "UITextSubClassHelper.h"


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


- (id)initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    _pickerView = [[UIPickerView alloc] init];
    [(UIPickerView *)_pickerView setDelegate:self];
    [(UIPickerView *)_pickerView setShowsSelectionIndicator:YES];
    return self;

}

- (UIView *)inputView {
    return _pickerView;
}

- (NSString *)selectedValue {
    NSInteger selected = [_pickerView selectedRowInComponent:0];
    return [self.dataSource objectAtIndex:(NSUInteger)selected];
}

- (void)donePicker {
    if ([self selectedValue]) {
        self.text = [self selectedValue];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
        if ([self.myDelegate respondsToSelector:@selector(savePickerView:)]) {
            [self.myDelegate savePickerView:_pickerView];
        }
#pragma clang diagnostic pop
        if ([self.myDelegate respondsToSelector:@selector(savePickerFrom:)]) {
            [self.myDelegate savePickerFrom:self];
        }
    }
    [super dismissPickerView];
}

@end
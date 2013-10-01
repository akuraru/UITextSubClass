//
//  Created by azu on 12/05/30.
//


@protocol UITextFieldWithPickerProtocol <NSObject>
- (void)savePickerFrom:(UITextFieldWithPicker *)textFieldWithPicker;
@optional
- (void)savePickerView:(UIPickerView *)pickerView __attribute__((deprecated("This method has been replaced by - saveFromUITextFieldWithPicker")));
@end
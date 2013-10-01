//
//  Created by azu on 12/05/30.
//

@class UITextFieldWithPicker;
@protocol UITextFieldWithPickerProtocol <NSObject>
@optional
- (void)savePickerFrom:(UITextFieldWithPicker *)textFieldWithPicker;
- (void)savePickerView:(UIPickerView *)pickerView __attribute__((deprecated("This method has been replaced by - saveFromUITextFieldWithPicker")));
@end
//
//  Created by azu on 12/05/30.
//

@class UITextFieldWithPicker;
@protocol UITextFieldWithPickerProtocol <UITextFieldDelegate>
@optional
- (void)savePickerFrom:(id)textFieldWithPicker;
- (void)savePickerView:(id)pickerView __attribute__((deprecated("This method has been replaced by - saveFromPicker")));
@end
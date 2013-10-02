//
//  Created by azu on 12/05/30.
//

@class UITextFieldWithPicker;
@protocol UITextFieldWithPickerProtocol <NSObject>
@optional
- (void)savePickerFrom:(id)textFieldWithPicker;
- (void)savePickerView:(id)pickerView __attribute__((deprecated("This method has been replaced by - saveFromPicker")));
@end
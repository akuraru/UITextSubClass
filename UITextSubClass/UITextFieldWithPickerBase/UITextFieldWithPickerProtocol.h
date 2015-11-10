//
//  Created by azu on 12/05/30.
//

@class UITextFieldWithPicker;
@protocol UITextFieldWithPickerProtocol <UITextFieldDelegate>
@optional
- (void)savePickerFrom:(id)textFieldWithPicker;
@end
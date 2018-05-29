//
//  Created by azu on 12/05/30.
//

#import <Foundation/Foundation.h>

@class UITextFieldWithPicker;
@protocol UITextFieldWithPickerProtocol <UITextFieldDelegate>
@optional
- (void)savePickerFrom:(id)textFieldWithPicker;

- (void)textField:(UITextField *)textField beginEditingWithPopoverViewController:(UIViewController *)viewController;

@end

//
//  UITextFieldWithPickerBase.h
//  UITextFieldWithPicker
//
//  Created by P.I.akura on 2013/08/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextFieldWithPickerBase : UITextField {
@protected
    id _pickerView;
	UIPopoverController *popoverController;
}
- (void)setDelegate:(id<UITextFieldDelegate>)delegate;
- (id<UITextFieldDelegate>)delegate;

@end

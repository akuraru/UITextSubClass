//
//  UITextFieldWithPickerBase.h
//  UITextFieldWithPicker
//
//  Created by P.I.akura on 2013/08/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UITextFieldWithPickerProtocol;

@interface UITextFieldWithPickerBase : UITextField {
@protected
    id _pickerView;
}

- (CGRect)pickerFrame;
- (void)dismissPickerView;

- (void)setDelegate:(id<UITextFieldWithPickerProtocol> _Nullable)delegate;
- (id<UITextFieldWithPickerProtocol> _Nullable)delegate;

- (void)donePicker;

@end

NS_ASSUME_NONNULL_END

//
//  Created by azu on 12/05/22.
//


#import <Foundation/Foundation.h>

@protocol UITextFieldWithDatePickerProtocol;

@interface UITextFieldWithDatePicker : UITextField {
}

@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic, strong) NSDate *date;
@property(nonatomic) UIDatePickerMode datePickerMode;
@property(nonatomic) NSInteger minuteInterval;
@property(nonatomic, weak) id <UITextFieldDelegate,UITextFieldWithDatePickerProtocol> delegate;

@property(nonatomic, strong) NSDateFormatter *dateFormatter;

- (void)updateText;


@end
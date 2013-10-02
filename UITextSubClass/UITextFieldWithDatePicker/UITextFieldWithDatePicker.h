//
//  Created by azu on 12/05/22.
//


#import <Foundation/Foundation.h>
#import "UITextFieldWithPickerBase.h"

@protocol UITextFieldWithPickerProtocol;

@interface UITextFieldWithDatePicker : UITextFieldWithPickerBase {
}

@property(nonatomic, strong) NSDateFormatter *dateFormatter;

- (NSDate *)date;

- (void)setDate:(NSDate *) date;

- (UIDatePickerMode)datePickerMode;

- (void)setDatePickerMode:(UIDatePickerMode) datePickerMode;

- (void)updateText;

#pragma mark - UIDatePickerModeCountDownTimer
- (NSInteger)minuteInterval;

- (void)setMinuteInterval:(NSInteger) minuteInterval;



@end
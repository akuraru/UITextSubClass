//
//  Created by azu on 12/05/22.
//


#import <Foundation/Foundation.h>
#import "UITextFieldWithPickerBase.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UITextFieldWithPickerProtocol;

@interface UITextFieldWithDatePicker : UITextFieldWithPickerBase

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic) NSDate *date;

@property (nonatomic) UIDatePickerMode datePickerMode;

- (void)updateText;

#pragma mark - UIDatePickerModeCountDownTimer
@property (nonatomic) NSInteger minuteInterval;

- (NSDate *)inputedDate;

@end

NS_ASSUME_NONNULL_END

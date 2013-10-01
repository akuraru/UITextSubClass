//
//  Created by azu on 12/05/22.
//


#import "UITextFieldWithDatePicker.h"
#import "UITextFieldWithDatePickerProtocol.h"
#import "UITextSubClassHelper.h"


@implementation UITextFieldWithDatePicker {
}

- (id)initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    _pickerView = [[UIDatePicker alloc] init];
	[_pickerView setFrame:[self pickerFrame]];
    [_pickerView setAutoresizingMask:UIViewAutoresizingNone];
    [_pickerView setMinuteInterval:0];
    [_pickerView setTimeZone:[NSTimeZone systemTimeZone]];
    return self;
}


- (UIDatePicker *)datePicker {
    return _pickerView;
}

- (NSDate *)date {
    return self.datePicker.date;
}

- (void)setDate:(NSDate *) date {
    if (date == nil) {
        return;
    }
    [self.datePicker setDate:date];
    [self updateText];
}

- (UIDatePickerMode)datePickerMode {
    return self.datePicker.datePickerMode;
}
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    self.datePicker.datePickerMode = datePickerMode;
}

- (NSInteger)minuteInterval {
    return self.datePicker.minuteInterval;
}
- (void)setMinuteInterval:(NSInteger)minuteInterval {
    self.datePicker.minuteInterval = minuteInterval;
}

- (UIView *)inputView {
    return self.datePicker;
}

- (void)updateText {
    // countdownだけ少し特殊
    if (self.datePickerMode == UIDatePickerModeCountDownTimer) {
        self.text = [self labelFromTimeInterval:self.datePicker.countDownDuration];
        return;
    }
    NSDateFormatter *dateFormatter = [self dateFormatter];
    self.text = [dateFormatter stringFromDate:self.datePicker.date];
}
- (NSDateFormatter *)dateFormatter {
    if (_dateFormatter) {
        return _dateFormatter;
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // http://qiita.com/items/868788c46315b0095869
        NSString *dateString = [self dateFormatString];
        [dateFormatter setDateFormat:dateString];
        return dateFormatter;
    }
}

- (NSString *)dateFormatString {
    switch (self.datePickerMode) {
        case UIDatePickerModeDate:
            return [NSDateFormatter dateFormatFromTemplate:@"yyyyMd" options:0 locale:[NSLocale currentLocale]];
        case UIDatePickerModeTime:
            return [NSDateFormatter dateFormatFromTemplate:@"HHmm" options:0 locale:[NSLocale currentLocale]];
        case UIDatePickerModeDateAndTime:
            return [NSDateFormatter dateFormatFromTemplate:@"yyyyMd HHmm" options:0 locale:[NSLocale currentLocale]];
        default:
            return nil;
    }
}

- (NSString *)labelFromTimeInterval:(NSTimeInterval) interval {
    NSTimeInterval theTimeInterval = interval;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *formDate = [NSDate date];
    NSDate *toDate = [NSDate dateWithTimeInterval:theTimeInterval sinceDate:formDate];
    NSCalendarUnit unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;
    NSDateComponents *conversionInfo = [calendar components:unitFlags fromDate:formDate toDate:toDate options:0];
    NSMutableString *mutableString = [NSMutableString string];
    if ([conversionInfo hour] != 0) {
        NSString *hour = NSLocalizedStringFromTableInBundle(@"%d hour", nil, [UITextSubClassHelper bundle], @"%d hour");
        [mutableString appendFormat:hour, [conversionInfo hour]];
    }
    if ([conversionInfo minute] != 0) {
        NSString *minute = NSLocalizedStringFromTableInBundle(@"%d min", nil, [UITextSubClassHelper bundle], @"%d min");
        [mutableString appendFormat:minute, [conversionInfo minute]];
    }

    return mutableString;
}

- (void)donePicker {
    if (self.datePicker.date != nil) {
        if ([self.myDelegate respondsToSelector:@selector(saveDateFrom:)]) {
            [self.myDelegate saveDateFrom:self];
        }
        [self updateText];
    }
	[super dismissPickerView];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
	UIMenuController *menuController = [UIMenuController sharedMenuController];
	if (menuController) {
		[UIMenuController sharedMenuController].menuVisible = NO;
	}
    
	return NO;
}

@end
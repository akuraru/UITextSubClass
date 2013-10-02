//
//  Created by azu on 12/05/22.
//


#import "UITextFieldWithDatePicker.h"
#import "UITextFieldWithPickerProtocol.h"
#import "UITextSubClassHelper.h"


@implementation UITextFieldWithDatePicker {
}

- (UIDatePicker *)datePicker {
    if (_pickerView == nil) {
        _pickerView = [[UIDatePicker alloc] init];
        [_pickerView setFrame:[self pickerFrame]];
        [_pickerView setAutoresizingMask:UIViewAutoresizingNone];
        [_pickerView setMinuteInterval:0];
        [_pickerView setTimeZone:[NSTimeZone systemTimeZone]];
    }
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
    self.text = [self selectedValue];
}

- (UIDatePickerMode)datePickerMode {
    return self.datePicker.datePickerMode;
}

- (void)setDatePickerMode:(UIDatePickerMode) datePickerMode {
    self.datePicker.datePickerMode = datePickerMode;
}

- (NSInteger)minuteInterval {
    return self.datePicker.minuteInterval;
}

- (void)setMinuteInterval:(NSInteger) minuteInterval {

    self.datePicker.minuteInterval = minuteInterval;
}

- (UIView *)inputView {
    return self.datePicker;
}
- (void)updateText {
    self.text = [self selectedValue];
}
- (NSString *)selectedValue {
    // countdown is special case
    if (self.datePickerMode == UIDatePickerModeCountDownTimer) {
        return [self labelFromTimeInterval:self.datePicker.countDownDuration];
    }
    NSDateFormatter *dateFormatter = [self dateFormatter];
    return [dateFormatter stringFromDate:self.datePicker.date];
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
        NSString *hour = NSLocalizedStringFromTableInBundle(@"%d hour", UITextSubClassLocalize, [UITextSubClassHelper bundle], @"%d hour");
        [mutableString appendFormat:hour, [conversionInfo hour]];
    }
    if ([conversionInfo minute] != 0) {
        NSString *minute = NSLocalizedStringFromTableInBundle(@"%d min", UITextSubClassLocalize, [UITextSubClassHelper bundle], @"%d min");
        [mutableString appendFormat:minute, [conversionInfo minute]];
    }

    return mutableString;
}

- (void)donePicker {
    if (self.datePicker.date != nil) {
        self.text = [self selectedValue];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
        if ([self.myDelegate respondsToSelector:@selector(savePickerView:)]) {
            [self.myDelegate savePickerView:_pickerView];
        }
#pragma clang diagnostic pop
        if ([self.myDelegate respondsToSelector:@selector(savePickerFrom:)]) {
            [self.myDelegate savePickerFrom:self];
        }
    }
    [super dismissPickerView];
}

- (BOOL)canPerformAction:(SEL) action withSender:(id) sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
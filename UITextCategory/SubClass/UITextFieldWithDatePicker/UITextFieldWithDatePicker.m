//
//  Created by azu on 12/05/22.
//


#import "UITextFieldWithDatePicker.h"
#import "UITextFieldWithDatePickerProtocol.h"


@implementation UITextFieldWithDatePicker {
}

@synthesize datePicker = _datePicker;
@synthesize datePickerMode = _datePickerMode;
@synthesize minuteInterval = _minuteInterval;


- (id)initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    return self;
}


- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.autoresizingMask = UIViewAutoresizingNone;
        _datePicker.minuteInterval = 0;
        [_datePicker setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return _datePicker;
}

- (NSDate *)date {
    return self.datePicker.date;
}

- (void)setDate:(NSDate *) date {
    if (date == nil) {
        return;
    }
    [self.datePicker setDate:date];
}

- (UIView *)inputView {
    self.datePicker.datePickerMode = self.datePickerMode;
    self.datePicker.minuteInterval = self.minuteInterval;

    return self.datePicker;
}

- (void)updateText {
    // countdownだけ少し特殊
    if (self.datePickerMode == UIDatePickerModeCountDownTimer) {
        self.text = [self labelFromTimeInterval:self.datePicker.countDownDuration];
        return;
    }
    // if user does not define dateFormatter
    if (self.dateFormatter == nil) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        // http://qiita.com/items/868788c46315b0095869
        NSString *dateString = nil;
        if (self.datePickerMode == UIDatePickerModeDate) {
            dateString = [NSDateFormatter dateFormatFromTemplate:@"yyyyMd" options:0 locale:[NSLocale currentLocale]];
        } else if (self.datePickerMode == UIDatePickerModeTime) {
            dateString = [NSDateFormatter dateFormatFromTemplate:@"HHmm" options:0 locale:[NSLocale currentLocale]];
        } else if (self.datePickerMode == UIDatePickerModeDateAndTime) {
            dateString = [NSDateFormatter dateFormatFromTemplate:@"yyyyMd HHmm" options:0 locale:[NSLocale currentLocale]];
        }
        [self.dateFormatter setDateFormat:dateString];
    }
    self.text = [self.dateFormatter stringFromDate:self.datePicker.date];
}

- (NSString *)labelFromTimeInterval:(NSTimeInterval) interval {
    NSTimeInterval theTimeInterval = interval;
// Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
// Create the NSDates
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:date1];
// Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit;

    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1 toDate:date2 options:0];
    NSMutableString *mutableString = [NSMutableString string];
    if ([conversionInfo hour] != 0) {
        [mutableString appendFormat:@"%d時間", [conversionInfo hour]];
    }
    if ([conversionInfo minute] != 0) {
        [mutableString appendFormat:@"%d分", [conversionInfo minute]];
    }

    return mutableString;
}

- (void)done {
    if (self.datePicker.date != nil) {
        if ([self.delegate respondsToSelector:@selector(saveDateFrom:)]) {
            [self.delegate saveDateFrom:self];
        }
        [self updateText];
    }
    [self resignFirstResponder];
}

- (void)cancelDatePicker {
    [self resignFirstResponder];
}

- (UIView *)inputAccessoryView {
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];

    UIBarButtonItem *cancelButton;
    cancelButton = [[UIBarButtonItem alloc] init];
    cancelButton.style = UIBarButtonItemStyleBordered;
    cancelButton.tintColor = nil;
    cancelButton.title = NSLocalizedString(@"Cancel", @"Cancel");
    cancelButton.target = self;
    cancelButton.action = @selector(cancelDatePicker);
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                 target:nil action:nil];
    UIBarButtonItem *doneButton;
    doneButton = [[UIBarButtonItem alloc] init];
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.tintColor = nil;
    doneButton.title = NSLocalizedString(@"Done", @"Done");
    doneButton.target = self;
    doneButton.action = @selector(done);
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:cancelButton, centerSpace, doneButton, nil]];

    return keyboardDoneButtonView;
}

@end
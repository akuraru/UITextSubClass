//
//  Created by azu on 12/05/22.
//


#import "UITextFieldWithDatePicker.h"
#import "UITextFieldWithDatePickerProtocol.h"


@implementation UITextFieldWithDatePicker {
}

@synthesize datePicker = datePicker_;
@synthesize datePickerMode = datePickerMode_;
@synthesize minuteInterval = _minuteInterval;


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self){
        return nil;
    }
    return self;
}


- (UIDatePicker *)datePicker {
    if (datePicker_ == nil){
        datePicker_ = [[UIDatePicker alloc] init];
        datePicker_.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [datePicker_ setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return datePicker_;
}

- (NSDate *)date {
    return self.datePicker.date;
}

- (UIView *)inputView {
    if (self.datePickerMode == UIDatePickerModeDate){
        self.datePicker.datePickerMode = UIDatePickerModeDate;
    } else if (self.datePickerMode == UIDatePickerModeTime){
        self.datePicker.datePickerMode = UIDatePickerModeTime;
    } else if (self.datePickerMode == UIDatePickerModeDateAndTime){
        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }

    self.datePicker.minuteInterval = self.minuteInterval;

    return self.datePicker;
}

- (void)updateText {
    // http://tech-gym.com/2012/10/ios/893.html
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setCalendar:calendar];
    if (self.datePickerMode == UIDatePickerModeDate){
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    } else if (self.datePickerMode == UIDatePickerModeTime){
        [dateFormatter setDateFormat:@"HH:mm"];
    } else if (self.datePickerMode == UIDatePickerModeDateAndTime){
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    }
    self.text = [dateFormatter stringFromDate:self.datePicker.date];
}

- (void)done {
    if (self.datePicker.date != nil){
        if ([self.delegate respondsToSelector:@selector(saveDate:)]){
            [self.delegate saveDate:self];
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
    cancelButton.title = @"キャンセル";
    cancelButton.target = self;
    cancelButton.action = @selector(cancelDatePicker);
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
                                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
        target:nil action:nil];
    UIBarButtonItem *doneButton;
    doneButton = [[UIBarButtonItem alloc] init];
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.tintColor = nil;
    doneButton.title = @"保存";
    doneButton.target = self;
    doneButton.action = @selector(done);
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:cancelButton, centerSpace, doneButton, nil]];

    return keyboardDoneButtonView;
}

@end
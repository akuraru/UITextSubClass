# What is this

UITextField/UITextView subclass.

![UITextField+DatePicker](https://monosnap.com/image/TSwA3hPoDkdrr1jJRnGaaFQpI.png)

## Installation

CocoaPods

``` ruby
pod 'UITextSubClass', :git => 'https://github.com/azu/UITextSubClass.git'
```


* D&D UITextSubClass/* to your project


## Usage

### UITextFieldWithDatePicker

UITextFieldWithDatePicker is UITextField subclass

    UITextFieldWithDatePicker *dateTextField = [[UITextFieldWithDatePicker alloc]init];
    dateTextField.myDelegate = self;
    // set DatePicker type
    dateTextField.datePickerMode = UIDatePickerModeDate;

if set ``UIDatePickerModeTime``, you can set default minuteInterval :

    dateTextField.minuteInterval = 60; // default minuteInterval

You can pass original dateformatter:
(Sending no dateformatter to dateTextField, will use ``dateFormatFromTemplate:``)

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateTextField.dateFormatter = dateFormatter;

manually update TextField

    [dateTextField updateText];

get selected date

    dateTextField.date;// <NSDate>
    // also set date
    dateTextField.date = [NSDate date];
    [dateTextField updateText];

### UITextFieldToolBar

UITextFieldToolBar is UITextField subclass

Simply add @"done" button.
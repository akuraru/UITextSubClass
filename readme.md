# What is this

UITextField/UITextView subclass.

![UITextField+DatePicker](https://monosnap.com/image/TSwA3hPoDkdrr1jJRnGaaFQpI.png)

## Installation

### CocoaPods

``` ruby
pod 'UITextSubClass', :git => 'https://github.com/azu/UITextSubClass.git'
```

if you want to use one components, install specific subspec.

``` ruby
pod 'UITextSubClass/UITextFieldWithDatePicker'
```

### Direct

* D&D UITextSubClass/* to your project

## Summary

* UITextFieldWithPicker
    * UITextField + UIPickerView.
* UITextFieldWithDatePicker
    * UITextField + UIDatePicker.
* UITextFieldWithDecimalPad
    * UITextField + ``keyboardType = UIKeyboardTypeDecimalPad`` +  treat decimal point.
* UITextFieldWithNumberPad
    * UITextField + ``keyboardType = UIKeyboardTypeNumberPad`` +   input control.
* UITextFieldWithToolbar
    * UITextField + UIToolbar(inputAccessoryView)
* UITextViewWithToolbar
    * UITextView + Placeholder + layer customized


## Usage

### UITextFieldWithDatePicker

UITextFieldWithDatePicker is UITextField subclass

    UITextFieldWithDatePicker *dateTextField = [[UITextFieldWithDatePicker alloc]init];
    dateTextField.myDelegate = self;
    // set DatePicker type
    dateTextField.datePickerMode = UIDatePickerModeDate;

if setting ``UIDatePickerModeTime``, you should also set default minuteInterval :

    dateTextField.minuteInterval = 60; // default minuteInterval

You can pass original UIDateFormatter:
(Defaults: use ``dateFormatFromTemplate:``)

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateTextField.dateFormatter = dateFormatter;

manually update TextField

    [dateTextField updateText];

get selected date

    dateTextField.date;// <NSDate>
    // also set date & update
    dateTextField.date = [NSDate date];

### UITextFieldToolBar

UITextFieldToolBar is UITextField subclass

Simply add @"donePicker" button.
# UITextSubClass [![Build Status](https://travis-ci.org/azu/UITextSubClass.svg?branch=master)](https://travis-ci.org/azu/UITextSubClass)

This library is collection of UIText(View|Field) subclasses.

* a variety of subclass
* support iPad(

## Installation

### CocoaPods

``` ruby
pod 'UITextSubClass', :git => 'https://github.com/azu/UITextSubClass.git'
```

if you want to use one components, install specific subspec.

``` ruby
pod 'UITextSubClass/UITextFieldWithDatePicker'
```

## UI Components Summary

![img](http://monosnap.com/image/glhUDgrh3S2h6ZWZd90TYgNMZoBcuN.png)
![img](http://monosnap.com/image/uHJhaFSbi5yLFVNcRtMdHJZpDq3H3Y.png)

### UITextFieldWithPicker

UITextField + UIPickerView.

### UITextFieldWithDatePicker

UITextField + UIDatePicker.

### UITextFieldWithDecimalPad

UITextField + ``keyboardType = UIKeyboardTypeDecimalPad`` +  treat decimal point.

You have to set `significantFigures`.

```objc
@property (nonatomic) NSUInteger significantFigures;
```

### UITextFieldWithNumberPad

UITextField + ``keyboardType = UIKeyboardTypeNumberPad`` +   input control.

### UITextFieldWithToolbar

UITextField + UIToolbar(inputAccessoryView)

### UITextViewWithToolbar

UITextView + Placeholder + layer customized


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

To get selected date

    [dateTextField inputedDate];// <NSDate>


## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

MIT
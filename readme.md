# What is this

UITextField/UITextView subclass.

![UITextField+DatePicker](https://monosnap.com/image/TSwA3hPoDkdrr1jJRnGaaFQpI.png)

## Usage

* D&D SubClass/* to your project

### UITextFieldWithDatePicker

UITextFieldWithDatePicker is UITextField subclass

    UITextFieldWithDatePicker *dateTextField = [[UITextFieldWithDatePicker alloc]init];
    // set datePickerMode
    dateTextField.delegate = self;
    // set DatePicker type
    dateTextField.datePickerMode = UIDatePickerModeDate;

if set ``UIDatePickerModeTime``

    dateTextField.minuteInterval = 60; // default minuteInterval

You can pass original dateformatter

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateTextField.dateFormatter = dateFormatter;

manually update TextField

    [dateTextField updateText];

//
//  MyTableViewController.m
//  UITextCategory
//
//  Created by azu on 12/12/25.
//
//

#import "MyTableViewController.h"
#import "UITextFieldWithDatePicker.h"
#import "UITextFieldWithPicker.h"

@interface MyTableViewController ()

@end

@implementation MyTableViewController

- (id)initWithStyle:(UITableViewStyle) style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // set datePickerMode
    self.dateTextField.delegate = self;
    self.dateTextField.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateTextField.dateFormatter = dateFormatter;// pass original date formatter
    // countdown
    self.dateCountDownTextField.datePickerMode = UIDatePickerModeCountDownTimer;

    // UIPicker + UITextField
    self.pickerTextField.delegate = self;
    self.pickerTextField.dataSource = @[@"foo", @"biz", @"bar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self setDateTextField:nil];
}

#pragma mark - UITextField DatePicker delegate

- (void)savePickerFrom:(id) textField {
    if ([textField isKindOfClass:UITextFieldWithPicker.class]) {
        NSLog(@"textFieldWithPicker = %@", textField);
    } else {
        NSLog(@"textField.date = %@", [textField date]);
    }
}

- (void)textField:(UITextField *)textField beginEditingWithPopoverViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

@end

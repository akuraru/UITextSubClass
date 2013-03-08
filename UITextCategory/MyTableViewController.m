//
//  MyTableViewController.m
//  UITextCategory
//
//  Created by azu on 12/12/25.
//
//

#import "MyTableViewController.h"
#import "UITextFieldWithDatePicker.h"

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
    // set DatePicker type
    self.dateTextField.datePickerMode = UIDatePickerModeDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateTextField.dateFormatter = dateFormatter;// pass original date formatter
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setDateTextField:nil];
    [super viewDidUnload];
}

#pragma mark - UITextField DatePicker delegate
- (void)saveDateFrom:(UITextFieldWithDatePicker *) textField {
    NSLog(@"textField.date = %@", textField.date);
}

@end

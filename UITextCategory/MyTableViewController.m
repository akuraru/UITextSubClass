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
    self.dateTextField.datePickerMode = UIDatePickerModeDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setDateTextField:nil];
    [super viewDidUnload];
}
@end

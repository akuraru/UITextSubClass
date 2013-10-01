//
//  MyTableViewController.h
//  UITextCategory
//
//  Created by azu on 12/12/25.
//
//

#import <UIKit/UIKit.h>
#import "UITextFieldWithDatePickerProtocol.h"
#import "UITextFieldWithPickerProtocol.h"

@class UITextFieldWithDatePicker;
@class UITextFieldWithToolbar;
@class UITextFieldWithPicker;

@interface MyTableViewController : UITableViewController <UITextFieldDelegate, UITextFieldWithDatePickerProtocol, UITextFieldWithPickerProtocol>
@property (weak, nonatomic) IBOutlet UITextFieldWithDatePicker *dateTextField;
@property (weak, nonatomic) IBOutlet UITextFieldWithDatePicker *dateCountDownTextField;
@property (weak, nonatomic) IBOutlet UITextFieldWithPicker *pickerTextField;

@end

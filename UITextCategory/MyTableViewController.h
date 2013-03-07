//
//  MyTableViewController.h
//  UITextCategory
//
//  Created by azu on 12/12/25.
//
//

#import <UIKit/UIKit.h>
#import "UITextFieldWithDatePickerProtocol.h"

@class UITextFieldWithDatePicker;

@interface MyTableViewController : UITableViewController <UITextFieldDelegate, UITextFieldWithDatePickerProtocol>
@property (weak, nonatomic) IBOutlet UITextFieldWithDatePicker *dateTextField;

@end

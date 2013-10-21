//
//  Created by azu on 12/07/06.
//


#import <Foundation/Foundation.h>
#import "UITextFieldWithPickerBase.h"

@protocol UITextFieldWithPickerProtocol;


@interface UITextFieldWithPicker : UITextFieldWithPickerBase <UIPickerViewDelegate>

- (UIPickerView *)pickerView;
@property(nonatomic, strong) NSArray *dataSource;

- (NSString *)selectedValue;
- (NSInteger)selectedIndex;
- (void)setSelectedIndex:(NSInteger)index;

@end
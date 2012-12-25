//
//  Created by azu on 12/07/06.
//


#import <Foundation/Foundation.h>

@protocol UITextFieldWithPickerProtocol;


@interface UITextFieldWithPicker : UITextField <UIPickerViewDelegate>

@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, weak) id <UITextFieldWithPickerProtocol> delegate;

- (NSString *)selectedValue;

@end
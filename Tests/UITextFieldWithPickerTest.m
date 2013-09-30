//
//  UITextFieldWithPickerTest.m
//  UITextSubClass
//
//  Created by azu on 2013/09/30.
//
//

#import <XCTest/XCTest.h>
#import "UITextFieldWithPicker.h"
#import "OCMockObject.h"
#import "UITextFieldWithPickerProtocol.h"
#import "UITextFieldWithDatePickerProtocol.h"

@interface UITextFieldWithPicker(mock)
- (void)donePicker;
@end
@interface UITextFieldWithPickerTest : XCTestCase

@end

@implementation UITextFieldWithPickerTest {
    UITextFieldWithPicker *textFieldWithPicker;
}

- (void)setUp {
    [super setUp];
    textFieldWithPicker = [[UITextFieldWithPicker alloc] init];
    textFieldWithPicker.dataSource = @[@"a", @"b", @"c"];
}

- (void)tearDown {
    textFieldWithPicker = nil;
    [super tearDown];
}

- (void)testMyDelegate_when_selected {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(UITextFieldWithPickerProtocol)];
    [[mockDelegate expect] saveFromUITextFieldWithPicker:textFieldWithPicker];
    [[mockDelegate expect] savePickerView:textFieldWithPicker.pickerView];
    // given
    textFieldWithPicker.myDelegate = mockDelegate;
    // when
    [textFieldWithPicker.pickerView selectRow:1 inComponent:0 animated:NO];
    [textFieldWithPicker donePicker];
    // then
    [mockDelegate verify];
}

@end

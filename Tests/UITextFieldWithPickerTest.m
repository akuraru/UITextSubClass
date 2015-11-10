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

@interface UITextFieldWithPickerBase (mock)
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
    [[mockDelegate expect] savePickerFrom:textFieldWithPicker];
    // given
    textFieldWithPicker.delegate = mockDelegate;
    // when
    [textFieldWithPicker.pickerView selectRow:1 inComponent:0 animated:NO];
    [textFieldWithPicker donePicker];
    // then
    [mockDelegate verify];
}

@end

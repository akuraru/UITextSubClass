//
//  UITextFieldWithDatePickerTest.m
//  UITextSubClass
//
//  Created by azu on 2013/10/01.
//
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMockObject.h>
#import "UITextFieldWithDatePicker.h"
#import "UITextFieldWithDatePickerProtocol.h"
@interface UITextFieldWithDatePicker(mock)
- (void)donePicker;
@end

@interface UITextFieldWithDatePickerTest : XCTestCase

@end

@implementation UITextFieldWithDatePickerTest {
    UITextFieldWithDatePicker *textFieldWithPicker;
}

- (void)setUp {
    [super setUp];
    textFieldWithPicker = [[UITextFieldWithDatePicker alloc] init];

}

- (void)tearDown {
    [super tearDown];
}

- (void)testMyDelegate_when_done {
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(UITextFieldWithDatePickerProtocol)];
    [[mockDelegate expect] saveDateFrom:textFieldWithPicker];
    // given
    textFieldWithPicker.myDelegate = mockDelegate;
    // when
    textFieldWithPicker.date = [NSDate date];
    [textFieldWithPicker donePicker];
    // then
    [mockDelegate verify];

}


@end

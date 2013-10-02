//
//  UITextFieldWithDatePickerTest.m
//  UITextSubClass
//
//  Created by azu on 2013/10/01.
//
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMockObject.h>
#import <OCMock/OCMArg.h>
#import "UITextFieldWithDatePicker.h"
#import "UITextFieldWithPickerProtocol.h"

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
    id mockDelegate = [OCMockObject mockForProtocol:@protocol(UITextFieldWithPickerProtocol)];
    [[mockDelegate expect] savePickerFrom:textFieldWithPicker];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
    [[mockDelegate expect] savePickerView:OCMOCK_ANY];
#pragma clang diagnostic pop
    // given
    textFieldWithPicker.myDelegate = mockDelegate;
    // when
    textFieldWithPicker.date = [NSDate date];
    [textFieldWithPicker donePicker];
    // then
    [mockDelegate verify];

}


@end

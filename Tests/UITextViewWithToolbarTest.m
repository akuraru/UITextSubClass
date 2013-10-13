//
//  UITextViewWithToolbarTest.m
//  UITextSubClass
//
//  Created by azu on 2013/09/30.
//
//

#import <XCTest/XCTest.h>
#import "UITextViewWithToolbar.h"
#import "OCMock.h"

@interface UITextViewWithToolbar(mock)
- (void)updatePlaceholderLabel;
@end
@interface UITextViewWithToolbarTest : XCTestCase

@end

@implementation UITextViewWithToolbarTest {
    UITextViewWithToolbar *textViewWithToolbar;
    id textMock;
}

- (void)setUp {
    [super setUp];
    textViewWithToolbar = [[UITextViewWithToolbar alloc] init];
    textMock = [OCMockObject partialMockForObject:textViewWithToolbar];
}

- (void)tearDown {
    textViewWithToolbar = nil;
    [super tearDown];
}

- (void)testPlaceholder_text_is_nil {
    textViewWithToolbar.placeholderText = nil;
    XCTAssertEqual(textViewWithToolbar.placeholder.alpha, 0.0f);
    textViewWithToolbar.placeholderText = @"";
    XCTAssertEqual(textViewWithToolbar.placeholder.alpha, 0.0f);
}

- (void)testPlaceholder_text_is_filled {
    textViewWithToolbar.placeholderText = @"text";
    XCTAssertEqual(textViewWithToolbar.placeholder.alpha, 1.0f);
}

@end

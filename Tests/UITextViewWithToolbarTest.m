//
//  UITextViewWithToolbarTest.m
//  UITextSubClass
//
//  Created by azu on 2013/09/30.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "UITextViewWithToolbar.h"
#import "OCMock.h"

@interface UITextViewWithToolbar (mock)
- (void)updatePlaceholderLabel;
@end

@interface UITextViewWithToolbarTest : SenTestCase

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
    STAssertEquals(textViewWithToolbar.placeholder.alpha, 0.0f, @"alpha is default");
    textViewWithToolbar.placeholderText = @"";
    STAssertEquals(textViewWithToolbar.placeholder.alpha, 0.0f, @"alpha is default");
}

- (void)testPlaceholder_text_is_filled {
    textViewWithToolbar.placeholderText = @"text";
    STAssertEquals(textViewWithToolbar.placeholder.alpha, 1.0f, @"placeholder is hidden");
}

@end

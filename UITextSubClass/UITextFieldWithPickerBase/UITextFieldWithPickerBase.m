//
//  UITextFieldWithPickerBase.m
//  UITextFieldWithPicker
//
//  Created by P.I.akura on 2013/08/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import "UITextFieldWithPickerBase.h"
#import "UITextSubClassHelper.h"
#import "UITextFieldWithPickerProtocol.h"

#define kToolBarHeight 44
#define kPickerHeight 216
#define kPopOverHeight (kToolBarHeight + kPickerHeight)
#define kWeight 320

@interface UITextFieldWithPickerBase () <UITextFieldDelegate>
@end

@implementation UITextFieldWithPickerBase {
    id<UITextFieldWithPickerProtocol> baseDelegate;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [super setDelegate:self];
            baseDelegate = nil;
        }
    }
    return self;
}
- (NSString *)selectedValue {
    return nil;
}

- (CGRect)pickerFrame {
    return CGRectMake(0, kToolBarHeight, kWeight, kPickerHeight);
}
- (UIView *)inputView {
    return _pickerView;
}
- (BOOL)hasValue {
    return YES;
}

- (void)donePicker {
    if ([self hasValue]) {
        self.text = [self selectedValue];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        if ([baseDelegate respondsToSelector:@selector(savePickerView:)]) {
            [baseDelegate savePickerView:_pickerView];
        }
#pragma clang diagnostic pop
        if ([baseDelegate respondsToSelector:@selector(savePickerFrom:)]) {
            [baseDelegate savePickerFrom:self];
        }
    }
    [self dismissPickerView];
}

- (void)cancelPicker {
	[self dismissPickerView];
}
- (void)dismissPickerView {
	if (popoverController) {
		[popoverController dismissPopoverAnimated:YES];
    } else {
		[self resignFirstResponder];
	}
}

- (void)setDelegate:(id<UITextFieldWithPickerProtocol>)delegate {
    baseDelegate = delegate;
}
- (id<UITextFieldDelegate>)delegate {
    return baseDelegate;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([baseDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)] && [baseDelegate textFieldShouldBeginEditing:textField] == NO) {
        return NO;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		UIViewController *popoverContent = [[UIViewController alloc] init];
		[popoverContent.view addSubview:_pickerView];
		[popoverContent.view addSubview:self.inputAccessoryView];
        
		popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
		[popoverController presentPopoverFromRect:self.frame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		[popoverController setPopoverContentSize:CGSizeMake(kWeight, kPopOverHeight) animated:NO];
        return NO;
	} else {
        return YES;
    }
}


- (UIView *)inputAccessoryView {
    UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    [keyboardDoneButtonView sizeToFit];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] init];
    cancelButton.style = UIBarButtonItemStyleBordered;
    cancelButton.title = NSLocalizedStringFromTableInBundle(@"Cancel", UITextSubClassLocalize, [UITextSubClassHelper bundle], @"Cancel");
    cancelButton.target = self;
    cancelButton.action = @selector(cancelPicker);
    UIBarButtonItem *centerSpace = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                    target:nil action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] init];
    doneButton.style = UIBarButtonItemStyleDone;
    doneButton.title = NSLocalizedStringFromTableInBundle(@"Done", UITextSubClassLocalize, [UITextSubClassHelper bundle], @"Done");
    doneButton.target = self;
    doneButton.action = @selector(donePicker);
    [keyboardDoneButtonView setItems:@[cancelButton, centerSpace, doneButton]];
    
	keyboardDoneButtonView.frame = CGRectMake(0, 0, kWeight, kToolBarHeight);
    return keyboardDoneButtonView;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([baseDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [baseDelegate textFieldDidBeginEditing:textField];
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([baseDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [baseDelegate textFieldShouldEndEditing:textField];
    } else {
        return YES;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([baseDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [baseDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([baseDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [baseDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    } else {
        return NO;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([baseDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [baseDelegate textFieldShouldClear:textField];
    } else {
        return YES;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([baseDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        return [baseDelegate textFieldShouldReturn:textField];
    } else {
        return YES;
    }
}

@end

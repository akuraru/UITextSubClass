//
//  UITextFieldWithPickerBase.m
//  UITextFieldWithPicker
//
//  Created by P.I.akura on 2013/08/30.
//  Copyright (c) 2013年 P.I.akura. All rights reserved.
//

#import "UITextFieldWithPickerBase.h"

@interface UITextFieldWithPickerBase () <UITextFieldDelegate>
@end

@implementation UITextFieldWithPickerBase {
    id<UITextFieldDelegate> baseDelegate;
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

- (UIView *)inputView {
    return _pickerView;
}
- (void)doneDatePicker {
	if ([self selectedValue]) {
		self.text = [self selectedValue];
	}
	[self dismissPickerView];
}
- (void)cancelDatePicker {
	[self dismissPickerView];
}
- (void)dismissPickerView {
	if (popoverController) {
		[popoverController dismissPopoverAnimated:YES];
    } else {
		[self resignFirstResponder];
	}
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        baseDelegate = delegate;
    } else {
        [super setDelegate:delegate];
    }
}
- (id<UITextFieldDelegate>)delegate {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? baseDelegate : super.delegate;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([baseDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)] && [baseDelegate textFieldShouldBeginEditing:textField] == NO) {
    } else {
		UIViewController *popoverContent = [[UIViewController alloc] init];
		[popoverContent.view addSubview:_pickerView];
		[popoverContent.view addSubview:self.inputAccessoryView];
        
		popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
		[popoverController presentPopoverFromRect:self.frame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		[popoverController setPopoverContentSize:CGSizeMake(320, 264) animated:NO];
	}
    
    return NO;
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

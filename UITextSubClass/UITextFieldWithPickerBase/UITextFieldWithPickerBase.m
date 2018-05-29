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

@property (nonatomic, weak) UIViewController *popoverController;

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
	if (self.popoverController) {
		[self.popoverController dismissViewControllerAnimated:YES completion:nil];
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
		UIViewController *popoverController = [[UIViewController alloc] init];
		[popoverController.view addSubview:self.inputView];
		[popoverController.view addSubview:self.inputAccessoryView];
        
        popoverController.modalPresentationStyle = UIModalPresentationPopover;
        popoverController.popoverPresentationController.sourceView = self;
        popoverController.popoverPresentationController.sourceRect = self.frame;
        popoverController.preferredContentSize = CGSizeMake(kWeight, kPopOverHeight);
        
        if ([baseDelegate respondsToSelector:@selector(textField:beginEditingWithPopoverViewController:)]) {
            [baseDelegate textField:self beginEditingWithPopoverViewController:popoverController];
        }
        self.popoverController = popoverController;
        return NO;
	} else {
        return YES;
    }
}


- (UIView *)inputAccessoryView {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.translucent = YES;
    [toolbar sizeToFit];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] init];
    cancelButton.style = UIBarButtonItemStylePlain;
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
    [toolbar setItems:@[cancelButton, centerSpace, doneButton]];
    
	toolbar.frame = CGRectMake(0, 0, kWeight, kToolBarHeight);
    return toolbar;
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

- (BOOL)canPerformAction:(SEL) action withSender:(id) sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
@end

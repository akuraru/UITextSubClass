//
//  UITextViewWithToolbar.m
//
//  Created by azu on 11/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITextViewWithPlaceholder.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextViewWithPlaceholder ()
@property(nonatomic, strong) UILabel *placeholder;
@end

@implementation UITextViewWithPlaceholder

#pragma mark - placeholder

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupPlaceholder {
    if ([self placeholder]) {
        return;
    }

    CGRect frame = CGRectMake(8, 8, self.bounds.size.width - 16, 0.0);
    self.placeholder = [[UILabel alloc] initWithFrame:frame];
    [self.placeholder setLineBreakMode:NSLineBreakByWordWrapping];
    [self.placeholder setNumberOfLines:0];
    [self.placeholder setBackgroundColor:[UIColor clearColor]];
    [self.placeholder setAlpha:1.0];
    [self.placeholder setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.placeholder setTextColor:[UIColor lightGrayColor]];
    [self addSubview:self.placeholder];
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.placeholder attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:8],
        [NSLayoutConstraint constraintWithItem:self.placeholder attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:8],
        [NSLayoutConstraint constraintWithItem:self.placeholder attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-8],
        [NSLayoutConstraint constraintWithItem:self.placeholder attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-16],
    ]];
    
    [self sendSubviewToBack:self.placeholder];

    [self setPlaceholder:self.placeholder];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lostFocus:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupPlaceholder];
    [self setUpStyle];
}

// style customize - https://github.com/tomohisa/JTCCustomizableUIComponent
- (void)setUpStyle {
    if (_borderColor) {
        self.layer.borderColor = _borderColor.CGColor;
    }
    if (_shadowColor) {
        self.layer.shadowColor = _shadowColor.CGColor;
    }
    if (_shadowOpacity) {
        self.layer.shadowOpacity = [_shadowOpacity floatValue];
    }
    if (_borderWidth) {
        self.layer.borderWidth = [_borderWidth floatValue];
    }
    if (_shadowRadius) {
        self.layer.shadowRadius = [_shadowRadius floatValue];
    }
    if (_cornerRadius) {
        self.layer.cornerRadius = [_cornerRadius floatValue];
    }
    if (_shadowOffset) {
        self.layer.shadowOffset = [_shadowOffset CGSizeValue];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupPlaceholder];
    }
    return self;
}

- (instancetype _Nullable)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupPlaceholder];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPlaceholder];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification {
    [self updatePlaceholderLabel];
}

- (void)lostFocus:(NSNotification *)notification {
    [self updatePlaceholderLabel];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self updatePlaceholderLabel];
}

- (void)updatePlaceholderLabel {
    if ([[self text] length] == 0 && [[self.placeholder text] length] > 0) {
        [self.placeholder setAlpha:1.0];
    } else {
        [self.placeholder setAlpha:0.0];
    }
}

- (void)setFont:(UIFont * _Nullable)font {
    [super setFont:font];
    [self.placeholder setFont:self.font];
    [self updatePlaceholderLabel];
    [self.placeholder sizeToFit];
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    [self.placeholder setText:placeholderText];
    [self updatePlaceholderLabel];
    [self.placeholder sizeToFit];

}

- (UIColor *)placeholderColor {
    return [self.placeholder textColor];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    [self.placeholder setTextColor:placeholderColor];
    [self updatePlaceholderLabel];
    [self.placeholder sizeToFit];
}

@end

NS_ASSUME_NONNULL_END

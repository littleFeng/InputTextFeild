//
//  JRInputTextField.m
//  Demo
//
//  Created by fenglishuai on 15/12/14.
//  Copyright © 2015年 user. All rights reserved.
//

#import "JRInputTextField.h"

#define  IOS7      [[UIDevice currentDevice].systemVersion floatValue]>=7.0

@interface JRInputTextField ()

@property (nonatomic, strong, readonly) UILabel * floatingLabel;
@property (nonatomic, assign) CGFloat  floatingLabelY;
@property (nonatomic, strong) UIColor * floatingLabelTextColor;  
@property (nonatomic, assign) NSInteger animateEvenIfNotFirstResponder;
@property (nonatomic, assign)   CGSize    activeSize;
@property (nonatomic, assign)   CGSize    normalSize;

@end

@implementation JRInputTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        self.disableCopyActions = NO;

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
        self.disableCopyActions = NO;
        if (self.placeholder) {
            self.placeholder = self.placeholder;
        }
    }
    return self;
}

- (void)commonInit
{
    _floatingLabel = [UILabel new];
    [self addSubview:_floatingLabel];
    _floatingLabelTextColor = [UIColor grayColor];
    _animateEvenIfNotFirstResponder = NO;
}

#pragma mark -setter and getter

- (UIColor *)getLabelActiveColor
{
    if (_floatingLabelActiveTextColor) {
        return _floatingLabelActiveTextColor;
    }
    else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    return [UIColor blueColor];
}

-(void)setFloatingLabelActiveTextColor:(UIColor *)floatingLabelActiveTextColor
{
    _floatingLabelActiveTextColor=floatingLabelActiveTextColor;
    _floatingLabel.textColor = floatingLabelActiveTextColor;
}

- (void)setFloatingLabelFont:(UIFont *)floatingLabelFont
{
    _floatingLabelFont = floatingLabelFont;
    _floatingLabel.font = _floatingLabelFont;
    [_floatingLabel sizeToFit];
    [self calculateSize];
}


-(void)setFloatingLabelText:(NSString *)floatingLabelText
{
    _floatingLabelText = floatingLabelText;
    _floatingLabel.text = floatingLabelText;
    _floatingLabel.font = _floatingLabelFont !=nil ? _floatingLabelFont : [UIFont systemFontOfSize:12.0f];
    [_floatingLabel sizeToFit];
    [self calculateSize];
    
}

- (void)setLabelOriginForTextAlignment
{
    CGRect textRect = [self textRectForBounds:self.bounds];
    
    CGFloat originX = textRect.origin.x;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        originX = textRect.origin.x + (textRect.size.width/2) - (_floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
    }
    else
    {
        originX= textRect.origin.x+3.0f;
    }
    
    _floatingLabel.frame = CGRectMake(originX, _floatingLabel.frame.origin.y,
                                      _floatingLabel.frame.size.width, _floatingLabel.frame.size.height);
}

-(void)calculateSize
{
    _activeSize = _floatingLabel.bounds.size;
    if(IOS7)
    _normalSize = [_floatingLabel.text sizeWithAttributes:@{ NSFontAttributeName:self.font }];
    else
        _normalSize = [_floatingLabel.text sizeWithFont:self.font];
}
#pragma mark- animation
- (void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)() = ^{
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          2.0f,
                                          _activeSize.width,
                                          _activeSize.height);
        _floatingLabel.textColor = _floatingLabelActiveTextColor;
        _floatingLabel.font = _floatingLabelFont !=nil ? _floatingLabelFont : [UIFont systemFontOfSize:12.0f];

    };
    
    if (animated || _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:^(BOOL finished) {
                             
                         }];
    }
    else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)() = ^{
        CGFloat originY = _floatingLabel.font.lineHeight+_floatingLabelY +(CGRectGetHeight(self.frame)-_floatingLabel.font.lineHeight-_floatingLabelY-self.font.lineHeight)*0.5f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          originY,
                                          _normalSize.width,
                                          _normalSize.height);
        _floatingLabel.textColor = [UIColor blackColor];
        _floatingLabel.font =self.font;
        
    };
    
    if (animated || _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:^(BOOL finished) {
                             
                         }];
    }
    else {
        hideBlock();
    }
}

#pragma mark - UITextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGFloat originY = _floatingLabel.font.lineHeight+_floatingLabelY +(CGRectGetHeight(self.frame)-_floatingLabel.font.lineHeight-_floatingLabelY-self.font.lineHeight)*0.5f;
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], UIEdgeInsetsMake(ceilf(originY), 0.0f, 0.0f, 0.0f));
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGFloat originY = _floatingLabel.font.lineHeight+_floatingLabelY +(CGRectGetHeight(self.frame)-_floatingLabel.font.lineHeight-_floatingLabelY-self.font.lineHeight)*0.5f;
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds], UIEdgeInsetsMake(ceilf(originY), 0.0f, 0.0f, 0.0f));
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    rect = CGRectMake(CGRectGetWidth(self.frame)-rect.size.width, (CGRectGetHeight(self.frame)- rect.size.height)*0.5f, rect.size.width, rect.size.height);
    return rect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
     return  UIEdgeInsetsInsetRect([super placeholderRectForBounds:bounds], UIEdgeInsetsMake(0, 5.0f, 0, 0));
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.text&&self.text.length > 1)
        return;
    
    if(!_floatingLabelText || [_floatingLabelText isEqualToString:@""])
        return;
    
    [self setLabelOriginForTextAlignment];

    BOOL firstResponder = self.isFirstResponder;
    if (!firstResponder && (!self.text || self.text.length ==0 ) && !                                                                                                                                 _isFloatLabelActive) {
        [self hideFloatingLabel:YES];
    }
    else {
        [self showFloatingLabel:YES];
    }
    
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (self.disableCopyActions) {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}


-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    if(enabled)
        return;
    else
    {
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          2.0f,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
        _floatingLabel.textColor = _floatingLabelActiveTextColor;
        _floatingLabel.font = _floatingLabelFont !=nil ? _floatingLabelFont : [UIFont systemFontOfSize:12.0f];
    }
}

-(void)setIsFloatLabelActive:(BOOL)isFloatLabelActive
{
    _isFloatLabelActive = isFloatLabelActive;
    
    if(isFloatLabelActive)
    {
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          2.0f,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
        _floatingLabel.textColor = _floatingLabelActiveTextColor;
        _floatingLabel.font = _floatingLabelFont !=nil ? _floatingLabelFont : [UIFont systemFontOfSize:12.0f];
    }
    else
        return;
}
@end

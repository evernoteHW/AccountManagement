//
//  BaseIBView.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/30.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "BaseIBView.h"

@implementation BaseIBView
- (void)setBorderColor:(UIColor *)borderColor
{
    if (_borderColor != borderColor) {
        _borderColor = borderColor;
        [self setNeedsDisplay];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    if (_borderWidth != borderWidth) {
        _borderWidth = borderWidth;
        [self setNeedsDisplay];
    }
}

- (void)setMasksToBounds:(BOOL)masksToBounds
{
    if (_masksToBounds != masksToBounds) {
        _masksToBounds = masksToBounds;
        [self setNeedsDisplay];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    if (_cornerRadius != cornerRadius) {
        _cornerRadius = cornerRadius;
        [self setNeedsDisplay];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _customInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _customInit];
        
    }
    return self;
}

- (void)_customInit {
    _borderColor = [UIColor greenColor];
    _borderWidth = 5;
    _masksToBounds = YES;
    _cornerRadius = 5;
    
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.layer.cornerRadius = _cornerRadius;
    self.layer.borderWidth = _borderWidth;
    self.layer.borderColor = _borderColor.CGColor;
    self.layer.masksToBounds = _masksToBounds;
}

@end

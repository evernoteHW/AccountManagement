//
//  CustomTitleButton.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/17.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CustomTitleView.h"

@implementation CustomTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customTitleViewAction:)];
    
    [self addGestureRecognizer:tap];
    
}

- (void)customTitleViewAction:(UITapGestureRecognizer *)tap
{
    
}

@end

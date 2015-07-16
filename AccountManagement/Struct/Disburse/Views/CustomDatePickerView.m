//
//  CustomDatePickerView.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/14.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CustomDatePickerView.h"


@implementation CustomDatePickerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 66, [UIApplication sharedApplication].keyWindow.frame.size.width, 200)];
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"zh_Hans_CN"]];
    [self addSubview:datePicker];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height - 200, [UIApplication sharedApplication].keyWindow.frame.size.width, 200);
    }];
}
- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height , [UIApplication sharedApplication].keyWindow.frame.size.width, 200);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

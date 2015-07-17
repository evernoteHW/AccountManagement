
//
//  CustomPickerView.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/14.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CustomDatePickerView.h"

static CustomDatePickerView *shareInstance = nil;

#define CustomPickerViewHeight   215

@implementation CustomDatePickerView

+ (id)showCustomPickerWithDate:(NSDate *)cureentDate selectedBlcok:(SelectedTimerBlcok)selectedTimerBlcok
{
    shareInstance = [CustomDatePickerView shareInstance];
    
    shareInstance.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height, [UIApplication sharedApplication].keyWindow.frame.size.width, CustomPickerViewHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:shareInstance];
    
    shareInstance.selectedTimeBlcok = selectedTimerBlcok;
    
    [shareInstance showCustomPickerView];
    
    shareInstance.pickerView.backgroundColor = [UIColor colorWithR:110 G:149 B:255];
    
    [shareInstance.pickerView setTimeZone:[NSTimeZone timeZoneWithName:@"zh_Hans_CN"]];
    
    [shareInstance.pickerView addTarget:shareInstance action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
    
    return shareInstance;
}

+ (CustomDatePickerView *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NSBundle mainBundle] loadNibNamed:@"CustomDatePickerView" owner:self options:nil].lastObject;
    });
    return shareInstance;
}

- (void)datePickerAction:(UIDatePicker *)piker
{
    if (self.selectedTimeBlcok) {
        self.selectedTimeBlcok([NSDate getTimeStr1:[piker.date timeIntervalSince1970]],piker.date);
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (IBAction)hidenBtnAction:(UIButton *)sender {
    [self hiddenCustomPickerView];
}
- (void)showCustomPickerView
{
    CGRect frame = shareInstance.frame;
    frame.origin.y = [UIApplication sharedApplication].keyWindow.frame.size.height ;
    shareInstance.frame = frame;
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect frame = shareInstance.frame;
        frame.origin.y = [UIApplication sharedApplication].keyWindow.frame.size.height - CustomPickerViewHeight;
        shareInstance.frame = frame;
        
    }completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenCustomPickerView
{
    CGRect frame = shareInstance.frame;
    frame.origin.y = [UIApplication sharedApplication].keyWindow.frame.size.height - CustomPickerViewHeight;
    shareInstance.frame = frame;
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect frame = shareInstance.frame;
        frame.origin.y = [UIApplication sharedApplication].keyWindow.frame.size.height ;
        shareInstance.frame = frame;
        
    }completion:^(BOOL finished) {
        if (self.hiddenBlcok) {
            self.hiddenBlcok();
        }
    }];
}
@end

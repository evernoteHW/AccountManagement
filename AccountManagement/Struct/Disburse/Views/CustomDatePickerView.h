//
//  CustomPickerView.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/14.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectedTimerBlcok)(NSString *,id);

@interface CustomDatePickerView : UIView

@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;

@property (strong, nonatomic) NSArray *dataArray;

@property (copy, nonatomic) EditBlcok editBlcok;
@property (copy, nonatomic) HiddenBlcok hiddenBlcok;
@property (copy, nonatomic) SelectedTimerBlcok selectedTimeBlcok;

+ (CustomDatePickerView *)shareInstance;

+ (id)showCustomPickerWithDate:(NSDate *)cureentDate selectedBlcok:(SelectedTimerBlcok)selectedTimeBlcok;

- (IBAction)hidenBtnAction:(UIButton *)sender;
- (void)showCustomPickerView;
- (void)hiddenCustomPickerView;

@end

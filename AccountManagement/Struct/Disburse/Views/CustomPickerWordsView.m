
//
//  CustomPickerView.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/14.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CustomPickerWordsView.h"

static CustomPickerWordsView *shareInstance = nil;

#define CustomPickerViewHeight   197

@implementation CustomPickerWordsView

+ (id)showCustomPickerWithDataArray:(NSArray *)dataArray editBlcok:(EditBlcok )editBlcok hiddenBlcok:(HiddenBlcok)hiddenBlcok selectedBlcok:(SelectedBlcok)selectedBlcok;
{
    shareInstance = [CustomPickerWordsView shareInstance];
    
    shareInstance.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height, [UIApplication sharedApplication].keyWindow.frame.size.width, CustomPickerViewHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:shareInstance];
    
    shareInstance.editBlcok = editBlcok;
    shareInstance.hiddenBlcok = editBlcok;
    shareInstance.selectedBlcok = selectedBlcok;
    
    shareInstance.dataArray = dataArray;
    
    shareInstance.pickerView.dataSource = shareInstance;
    shareInstance.pickerView.delegate = shareInstance;
    
    [shareInstance.pickerView selectRow:0 inComponent:0 animated:YES];
    [shareInstance.pickerView reloadAllComponents];
    
    [shareInstance showCustomPickerView];
    
    return shareInstance;
}

+ (CustomPickerWordsView *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NSBundle mainBundle] loadNibNamed:@"CustomPickerWordsView" owner:self options:nil].lastObject;
    });
    return shareInstance;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return shareInstance.dataArray.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.selectedBlcok) {
        self.selectedBlcok(self.dataArray[row][1],@"");
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 44;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *bgView = [UIView new];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIApplication sharedApplication].keyWindow.center.x - 38, 7, 30, 30)];
    NSArray *arr = self.dataArray[row];
    imageView.image = [UIImage imageNamed:arr[0]];
    [bgView addSubview:imageView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIApplication sharedApplication].keyWindow.center.x , 0, 120, 44)];
    textLabel.text = arr[1];
    textLabel.font = [UIFont systemFontOfSize:18.0f];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = [UIColor whiteColor];
    
    [bgView addSubview:textLabel];
    
    return bgView;

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (IBAction)editBtnAction:(UIButton *)sender {
    if (self.editBlcok) {
        self.editBlcok();
    }
}

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

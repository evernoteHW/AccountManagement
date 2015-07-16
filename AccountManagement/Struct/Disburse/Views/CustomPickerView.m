
//
//  CustomPickerView.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/14.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CustomPickerView.h"

static CustomPickerView *shareInstance = nil;

#define CustomPickerViewHeight   197

@implementation CustomPickerView

+ (id)showCustomPickerWitheDataDic:(NSDictionary *)dataDic imageDic:(NSDictionary *)imageDic editBlcok:(EditBlcok )editBlcok hiddenBlcok:(HiddenBlcok)hiddenBlcok selectedBlcok:(SelectedBlcok)selectedBlcok
{
    shareInstance = [CustomPickerView shareInstance];
    
    shareInstance.frame = CGRectMake(0, [UIApplication sharedApplication].keyWindow.frame.size.height, [UIApplication sharedApplication].keyWindow.frame.size.width, CustomPickerViewHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:shareInstance];
    
    shareInstance.editBlcok = editBlcok;
    shareInstance.hiddenBlcok = editBlcok;
    shareInstance.selectedBlcok = selectedBlcok;
    
    shareInstance.dataDic = dataDic;
    shareInstance.imageDic = imageDic;
    
    shareInstance.pickerView.dataSource = shareInstance;
    shareInstance.pickerView.delegate = shareInstance;
    
    [shareInstance.pickerView selectRow:0 inComponent:0 animated:YES];
    [shareInstance.pickerView reloadAllComponents];
    
    shareInstance.titlerray = shareInstance.dataDic[shareInstance.dataDic.allKeys.firstObject];
    shareInstance.imageArray = shareInstance.imageDic[shareInstance.imageDic.allKeys.firstObject];
    
    [shareInstance showCustomPickerView];
    
    return shareInstance;
}

+ (CustomPickerView *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NSBundle mainBundle] loadNibNamed:@"CustomPickerView" owner:self options:nil].lastObject;
    });
    return shareInstance;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            return self.dataDic.allKeys.count;
        }
            break;
        case 1:
        {
            
            return  self.titlerray.count;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        return self.dataDic.allKeys[row];
    }else{
        return self.titlerray[row];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        selecteMenuItemIndex = row;
        
        self.titlerray = self.dataDic[self.dataDic.allKeys[row]];
        self.imageArray = self.imageDic[self.imageDic.allKeys[row]];
        
        selectChildItemIndex = 0;
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
    }
    
    if (component == 1) {
        selectChildItemIndex = row;
    }
    
    if (self.selectedBlcok) {
        self.selectedBlcok(self.dataDic.allKeys[selecteMenuItemIndex],self.titlerray[selectChildItemIndex]);
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 44;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    switch (component) {
        case 0:
        {
            
            UIView *view = [UIView new];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 30, 30)];
            imageView.image = [UIImage imageNamed:self.imageDic.allKeys[row]];
            [view addSubview:imageView];
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 0, 80, 44)];
            textLabel.text = self.dataDic.allKeys[row];
            textLabel.font = [UIFont systemFontOfSize:18.0f];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.textColor = [UIColor whiteColor];
            
            [view addSubview:textLabel];
            
            
            return view;
        }
            break;
        case 1:
        {
            
            
            UIView *view = [UIView new];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 30, 30)];
            imageView.image = [UIImage imageNamed:self.imageArray[row]];
            [view addSubview:imageView];
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 0, 80, 44)];
            textLabel.text = self.titlerray[row];
            textLabel.font = [UIFont systemFontOfSize:18.0f];
            textLabel.textAlignment = NSTextAlignmentCenter;
            textLabel.textColor = [UIColor whiteColor];
            [view addSubview:textLabel];
            
            return view;
        }
            break;
        default:
            break;
    }
    return nil;
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

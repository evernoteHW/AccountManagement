
//
//  CustomPickerView.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/14.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CustomPickerView.h"

@implementation CustomPickerView

+ (id)showInView:(UIView *)pickerSubview dataDic:(NSDictionary *)dataDic imageDic:(NSDictionary *)imageDic editBlcok:(EditBlcok )editBlcok hiddenBlcok:(HiddenBlcok)hiddenBlcok selectedBlcok:(SelectedBlcok)selectedBlcok
{
    
    CustomPickerView *pickerView = [[NSBundle mainBundle] loadNibNamed:@"CustomPickerView" owner:self options:nil].lastObject;
    pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    pickerSubview.backgroundColor = [UIColor redColor];
    [pickerSubview addSubview:pickerView];
    
    // align pickerView from the left and right
    [pickerSubview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pickerView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pickerView)]];
    
    // align pickerView from the bottom
    NSArray *mArr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pickerView(==170)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(pickerView)];
    pickerView.topConstraint = mArr.lastObject;
    
    [pickerSubview addConstraints:mArr];
    
    
    pickerView.editBlcok = editBlcok;
    pickerView.hiddenBlcok = editBlcok;
    pickerView.selectedBlcok = selectedBlcok;
    pickerView.dataDic = dataDic;
    pickerView.pickerSubview = pickerSubview;
    pickerView.imageDic = imageDic;
    
    pickerView.pickerView.dataSource = pickerView;
    pickerView.pickerView.delegate = pickerView;
    
    pickerView.titlerray = pickerView.dataDic[pickerView.dataDic.allKeys.firstObject];
    pickerView.imageArray = pickerView.imageDic[pickerView.imageDic.allKeys.firstObject];
    
    return pickerView;
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
    if (self.hiddenBlcok) {
        
        self.topConstraint.constant = -170;
        [UIView animateWithDuration:.3 animations:^{
            [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.hiddenBlcok();
        }];
    }
}

@end

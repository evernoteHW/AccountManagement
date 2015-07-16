//
//  CustomPickerView.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/14.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditBlcok)();
typedef void(^HiddenBlcok)();
typedef void(^SelectedBlcok)(NSString *,NSString *);

@interface CustomPickerView : UIView <UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSInteger selecteMenuItemIndex;
    NSInteger selectChildItemIndex;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *hiddenBtn;
@property (weak, nonatomic) IBOutlet UIView *pickerSubview;

@property (nonatomic, strong) NSLayoutConstraint *topConstraint;
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) NSDictionary *imageDic;

@property (strong, nonatomic) NSArray *titlerray;
@property (strong, nonatomic) NSArray *imageArray;

@property (copy, nonatomic) EditBlcok editBlcok;
@property (copy, nonatomic) HiddenBlcok hiddenBlcok;
@property (copy, nonatomic) SelectedBlcok selectedBlcok;

@property (strong, nonatomic) UIView *cusomtPickerBgView;

+ (CustomPickerView *)shareInstance;

+ (id)showCustomPickerWitheDataDic:(NSDictionary *)dataDic imageDic:(NSDictionary *)imageDic editBlcok:(EditBlcok )editBlcok hiddenBlcok:(HiddenBlcok)hiddenBlcok selectedBlcok:(SelectedBlcok)selectedBlcok;

- (IBAction)editBtnAction:(UIButton *)sender;
- (IBAction)hidenBtnAction:(UIButton *)sender;
- (void)showCustomPickerView;
- (void)hiddenCustomPickerView;

@end

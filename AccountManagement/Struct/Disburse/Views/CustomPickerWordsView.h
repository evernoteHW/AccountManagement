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

@interface CustomPickerWordsView : UIView <UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSInteger selecteMenuItemIndex;
    NSInteger selectChildItemIndex;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSArray *dataArray;

@property (copy, nonatomic) EditBlcok editBlcok;
@property (copy, nonatomic) HiddenBlcok hiddenBlcok;
@property (copy, nonatomic) SelectedBlcok selectedBlcok;

+ (CustomPickerWordsView *)shareInstance;

+ (id)showCustomPickerWithDataArray:(NSArray *)dataArray editBlcok:(EditBlcok )editBlcok hiddenBlcok:(HiddenBlcok)hiddenBlcok selectedBlcok:(SelectedBlcok)selectedBlcok;

- (IBAction)hidenBtnAction:(UIButton *)sender;
- (void)showCustomPickerView;
- (void)hiddenCustomPickerView;

@end

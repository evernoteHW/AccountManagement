//
//  DisburseDetailViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "DisburseDetailViewController.h"
#import "CustomDatePickerView.h"
#import "CustomPickerWordsView.h"

@interface DisburseDetailViewController () <UITextFieldDelegate,UITextViewDelegate>
{
    NSArray *titleArray;
    UIButton *hiddenBtn;
    CustomPickerView *customPickerView;
    UIDatePicker *datePicker;
}
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyTypeLabel;
@property (weak, nonatomic) IBOutlet UITableView *DisburseDetailTableView;

@end

@implementation DisburseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.moneyTextField.leftViewMode = UITextFieldViewModeAlways;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    label.font = [UIFont boldSystemFontOfSize:30.0f];
    label.textColor = [UIColor colorWithR:43 G:111 B:111];
    label.text = @"¥ ";
    self.moneyTextField.leftView = label;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
    selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    cell.selectedBackgroundView = selectedBackgroundView;
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [[CustomPickerView shareInstance] removeFromSuperview];
    [[CustomPickerWordsView shareInstance] removeFromSuperview];
    [hiddenBtn removeFromSuperview];
    [datePicker removeFromSuperview];
    
    switch (indexPath.row) {
        case 0:
        {
        
            [self.moneyTextField becomeFirstResponder];
        }
            break;
        case 1:
        {
           NSDictionary *titleDic =  @{@"衣服饰品":@[@"衣服裤子",@"鞋帽包包",@"化妆品"],
              @"食品酒水":@[@"早午晚餐",@"烟酒茶",@"水果零食"],
              @"居家物业":@[@"日常用品",@"水电煤气",@"房租",@"物业管理",@"维修保养"],
              @"行车交通":@[@"公共交通",@"打车租车",@"私家车费用"],
                                       @"衣服饰品":@[@"衣服裤子",@"鞋帽包包",@"化妆品"]};
            
        NSDictionary *imageDic = @{@"icon_yfsp":@[@"d_sfjj",@"d_shyp",@"d_slgzcl"],
                   @"d_muc":@[@"d_tlrjq",@"d_wanj",@"d_wj"],
                   @"d_nf":@[@"d_wysb",@"d_xtxt",@"d_yx",@"d_zg",@"d_zs"],
                   @"d_qcp":@[@"d_zszh",@"d_zxmr",@"defaultIcon"]
                                   };

            [CustomPickerView showCustomPickerWitheDataDic:titleDic imageDic:imageDic editBlcok:^{
                
            } hiddenBlcok:^{
                
            } selectedBlcok:^(NSString *menuItem, NSString *childItem) {
                
                self.categoryLabel.text = [NSString stringWithFormat:@"%@>%@",menuItem,childItem];
            }];
         
        }
            break;
        case 2:
        {

            NSArray *arr = @[@[@"icon_yfsp",@"现金(CNY)"],@[@"d_sfjj",@"信用卡(CNY)"],@[@"d_shyp",@"银行卡(CNY)"]];
                             
            [CustomPickerWordsView showCustomPickerWithDataArray:arr editBlcok:^{
                
            } hiddenBlcok:^{
                
            } selectedBlcok:^(NSString *menuItem, NSString *childItem) {
                self.moneyTypeLabel.text = menuItem;
            }];
  
        }
            break;
        case 3:
        {
            
            
            if (hiddenBtn == nil) {
                hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                hiddenBtn.backgroundColor = [UIColor blackColor];
                hiddenBtn.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height, 60, 35);
                [hiddenBtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
                [hiddenBtn addTarget:self action:@selector(hiddenBtnAction) forControlEvents:UIControlEventTouchUpInside];
            }
            [self.view addSubview:hiddenBtn];
            
            if (datePicker == nil) {
                datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height + 60, self.view.frame.size.width, 200)];
                datePicker.backgroundColor = [UIColor colorWithR:110 G:149 B:255];

                [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"zh_Hans_CN"]];
                
                [datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
            }
            [self.view addSubview:datePicker];
            
            [UIView animateWithDuration:0.3 animations:^{
                datePicker.frame = CGRectMake(0, self.view.frame.size.height - 180, self.view.frame.size.width, 200);
                
                hiddenBtn.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height - 215, 60, 35);
            }];
        }
        break;
        default:
            break;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[CustomPickerView shareInstance] removeFromSuperview];
    [[CustomPickerWordsView shareInstance] removeFromSuperview];
    [hiddenBtn removeFromSuperview];
    [datePicker removeFromSuperview];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [[CustomPickerView shareInstance] removeFromSuperview];
    [[CustomPickerWordsView shareInstance] removeFromSuperview];
    [hiddenBtn removeFromSuperview];
    [datePicker removeFromSuperview];
}

- (void)datePickerAction:(UIDatePicker *)piker
{
    self.timeLabel.text = [NSDate getTimeStr1:[piker.date timeIntervalSince1970]];
    NSLog(@"%@",self.timeLabel.text);
}
- (void)hiddenBtnAction
{
    [UIView animateWithDuration:0.3 animations:^{
        datePicker.frame = CGRectMake(0, self.view.frame.size.height + 60, self.view.frame.size.width, 200);
        
        hiddenBtn.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height , 60, 35);
    }completion:^(BOOL finished) {
        [hiddenBtn removeFromSuperview];
        [datePicker removeFromSuperview];
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

    [hiddenBtn removeFromSuperview];
    [datePicker removeFromSuperview];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    [[CustomPickerView shareInstance] removeFromSuperview];
    [[CustomPickerWordsView shareInstance] removeFromSuperview];
    [hiddenBtn removeFromSuperview];
    [datePicker removeFromSuperview];
    
 
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

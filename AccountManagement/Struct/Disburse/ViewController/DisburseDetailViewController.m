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
    NSDate *cureentDate;
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
- (IBAction)saveDisburseBtnAction:(id)sender {
    
    
    if (self.disburseModel) {
        
    }else
    {
        self.disburseModel = [DisburseModel BD_Create];
    }
    

    self.disburseModel.cureentDate = cureentDate;
    self.disburseModel.parentTime = [NSDate getTimeStr2Short:[cureentDate timeIntervalSince1970]];  //2015年4月
    self.disburseModel.childrTime = [NSDate getTimeStr3Short:[cureentDate timeIntervalSince1970]];  //2015年4月1日;
    self.disburseModel.totalTime = [NSDate getTimeStr1:[cureentDate timeIntervalSince1970]];        //2015年4月1日 13：39;
    
    self.disburseModel.moneyStr = self.moneyTextField.text;
    self.disburseModel.categoryStr =  self.categoryLabel.text;
    self.disburseModel.accountTypeStr = self.moneyTextField.text;
    self.disburseModel.timeStr = self.timeLabel.text;

    
    [self.disburseModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            //同一个月份 分到这个大组
            self.menuItemModel.relationFriends = [self.menuItemModel relationforKey:[NSString stringWithFormat:@"DisburseShips%@",self.disburseModel.timeStr]];
            
            [self.menuItemModel.relationFriends addObject:self.disburseModel];
            
            [self.menuItemModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    if (self.baseBlock) {
                        self.baseBlock(self.disburseModel);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    }];

    
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
    
    [self removeSubViews];

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
          
        }
        break;
        default:
            break;
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self removeSubViews];
   
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self removeSubViews];
 
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
 
  
}
- (void)removeSubViews
{
    [[CustomPickerView shareInstance] removeFromSuperview];
    [[CustomPickerWordsView shareInstance] removeFromSuperview];
    [[CustomDatePickerView shareInstance] removeFromSuperview];
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

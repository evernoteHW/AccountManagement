//
//  CashierDetailInfoViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/3.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CashierDetailInfoViewController.h"

@interface CashierDetailInfoViewController  ()
{
    NSDate *cureentDate;
}
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *morningPerson;
@property (weak, nonatomic) IBOutlet UILabel *dinnerPerson;
@property (weak, nonatomic) IBOutlet UILabel *afterPerson;

@property (weak, nonatomic) IBOutlet UITextField *remendMoney;
@property (weak, nonatomic) IBOutlet UITextField *salesMoneyTexField;
@property (weak, nonatomic) IBOutlet UITextField *cashMoeny;
@property (weak, nonatomic) IBOutlet UITextView *desContentTextView;

@end

@implementation CashierDetailInfoViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    cureentDate = [NSDate date];

}
- (IBAction)saveDetailInfoBtnAction:(UIButton *)sender {
    
    if (self.cashierModel) {

    }else
    {
        self.cashierModel = [CashierModel BD_Create];
    }
    
    self.cashierModel.cureentDate = cureentDate;
    self.cashierModel.parentTime = [NSDate getTimeStr2Short:[cureentDate timeIntervalSince1970]];  //2015年4月
    self.cashierModel.childrTime = [NSDate getTimeStr3Short:[cureentDate timeIntervalSince1970]];  //2015年4月1日;
    self.cashierModel.totalTime = [NSDate getTimeStr1:[cureentDate timeIntervalSince1970]];        //2015年4月1日 13：39;
    
    self.cashierModel.morningPersons = self.morningPerson.text;
    self.cashierModel.dinnerPersons = self.dinnerPerson.text;
    self.cashierModel.nightPersons = self.afterPerson.text;
    self.cashierModel.totalMoney = @"9988";
    self.cashierModel.deviation = @"+";
    self.cashierModel.sales = self.salesMoneyTexField.text;
    self.cashierModel.reservedMoney = self.remendMoney.text;
    self.cashierModel.comment = self.desContentTextView.text;
   
    [self.cashierModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            //同一个月份 分到这个大组
            self.menuItemModel.relationFriends = [self.menuItemModel relationforKey:[NSString stringWithFormat:@"CashierShips%@",self.cashierModel.parentTime]];
            
            [self.menuItemModel.relationFriends addObject:self.cashierModel];
            
            [self.menuItemModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    if (self.baseBlock) {
                        self.baseBlock(self.cashierModel);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    }];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[CustomPickerView shareInstance] removeFromSuperview];
    [[CustomPickerWordsView shareInstance] removeFromSuperview];
    [[CustomDatePickerView shareInstance] removeFromSuperview];
    
    switch (indexPath.row) {
        case 0:
        {
            [CustomDatePickerView showCustomPickerWithDate:[NSDate date] selectedBlcok:^(NSString *menuItem, NSDate *date__) {
                
                self.timeLabel.text = menuItem;
                cureentDate = date__;
                
            }];
            
        }
            break;
        case 1:
        case 2:
        case 3:
        {
            NSArray *arr = @[@[@"icon_yfsp",@"现金(CNY)"],@[@"d_sfjj",@"信用卡(CNY)"],@[@"d_shyp",@"银行卡(CNY)"]];
            
            [CustomPickerWordsView showCustomPickerWithDataArray:arr editBlcok:^{
                
            } hiddenBlcok:^{
                
            } selectedBlcok:^(NSString *menuItem, NSString *childItem) {
                if (indexPath.row == 0) {
                    self.morningPerson.text = menuItem;
                }else if (indexPath.row == 1)
                {
                    self.dinnerPerson.text = menuItem;
                }else
                {
                    self.afterPerson.text = menuItem;
                }
                
            }];
        }
            break;
        case 4:
        {
   
            
        }
            break;
        case 5:
        {
            
        
            
        }
            break;
        case 6:
        {
            
            
        }
            break;
        default:
            break;
    }
}

@end

//
//  CashierDetailInfoViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/3.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CashierDetailInfoViewController.h"

@interface CashierDetailInfoViewController  ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *morningPerson;
@property (weak, nonatomic) IBOutlet UILabel *dinnerPerson;
@property (weak, nonatomic) IBOutlet UILabel *afterPerson;

@property (weak, nonatomic) IBOutlet UITextField *remendMoney;
@property (weak, nonatomic) IBOutlet UITextField *cashMoeny;
@property (weak, nonatomic) IBOutlet UITextView *desContentTextView;

@end

@implementation CashierDetailInfoViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    

}
- (IBAction)saveDetailInfoBtnAction:(UIButton *)sender {
    
    NSInteger flagtype = 0;
    if (self.cashierModel) {
        flagtype = 0;
    }else
    {
        flagtype = 1;
        self.cashierModel = [CashierModel BD_Create];
    }
    //先查询一下 是否有这个大组
   
    [self.cashierModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            if (flagtype != 0) {
                self.menuItemModel.relationFriends = [self.menuItemModel relationforKey:[NSString stringWithFormat:@"CashierShips_%@",self.timeLabel.text]];
                [self.menuItemModel.relationFriends addObject:self.cashierModel];
            }
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
    
    switch (indexPath.row) {
        case 0:
        {
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
            
            
//            if (hiddenBtn == nil) {
//                hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//                hiddenBtn.backgroundColor = [UIColor blackColor];
//                hiddenBtn.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height, 60, 35);
//                [hiddenBtn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
//                [hiddenBtn addTarget:self action:@selector(hiddenBtnAction) forControlEvents:UIControlEventTouchUpInside];
//            }
//            [self.view addSubview:hiddenBtn];
//
//            if (datePicker == nil) {
//                datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height + 60, self.view.frame.size.width, 200)];
//                datePicker.backgroundColor = [UIColor colorWithR:110 G:149 B:255];
//                
//                [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"zh_Hans_CN"]];
//                
//                [datePicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
//            }
//            [self.view addSubview:datePicker];
//            
//            [UIView animateWithDuration:0.3 animations:^{
//                datePicker.frame = CGRectMake(0, self.view.frame.size.height - 180, self.view.frame.size.width, 200);
//                
//                hiddenBtn.frame = CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height - 215, 60, 35);
//            }];
        }
            break;
        default:
            break;
    }
}

@end

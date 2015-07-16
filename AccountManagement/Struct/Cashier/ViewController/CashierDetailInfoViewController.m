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

@end

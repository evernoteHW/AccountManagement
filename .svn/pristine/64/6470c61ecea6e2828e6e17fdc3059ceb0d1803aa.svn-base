//
//  RegisterTableViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/6.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "RegisterTableViewController.h"

@interface RegisterTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;

@end

@implementation RegisterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (IBAction)regiesterBtnAction:(UIButton *)sender {
    
    [SVProgressHUD show];
    
    UserLoginModel *user = [UserLoginModel user];
    user.username = self.userNameTextField.text;
    user.email = self.mailTextField.text;
    user.password =  self.pwdTextField.text;
//    [user setObject:@"213-253-0000" forKey:@"phone"];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSArray *menuItemNameArr = @[@"通讯录 ",@"货单",@"订单",@"收银",@"绩效",@"支出",@"查询",@"分析"];
            //默认配置
            NSMutableArray *modelArray = [NSMutableArray array];
            
            for (NSString *menuItemName in menuItemNameArr) {
                
                MenuItemModel *addressBookEntity = [MenuItemModel objectWithClassName:NSStringFromClass([MenuItemModel class])];
                addressBookEntity.menuItemName = menuItemName;
                
                [modelArray addObject:addressBookEntity];
            }
            
            //数组形式保存
            [AVObject saveAllInBackground:modelArray block:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    user.menuItemFriendsShip = [user relationforKey:@"menuItemNameArr"];
                    for (MenuItemModel *addressBookEntity in modelArray) {
                        [user.menuItemFriendsShip addObject:addressBookEntity];
                    }
                    //update the postedMessage
                    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                            
                            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                            
                            [[NSUserDefaults standardUserDefaults] setObject:self.userNameTextField.text  forKey:kUSERNAME];
                            [[NSUserDefaults standardUserDefaults] setObject:self.pwdTextField.text  forKey:kUSERPASSWARD];
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:kAutoLoginInNotification object:nil];
                        }
                    }];
                }
            }];
            
        } else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error.description]];
        }
    }];

}
@end

//
//  SettingTableViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/6.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "SettingTableViewController.h"

@implementation SettingTableViewController

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 0) {
        [UserLoginModel logOut];
        [UIApplication sharedApplication].keyWindow.rootViewController = [self storyBoardWithIdentifier:@"LoginAndRegiestNavigationController"];
    }
}
@end

//
//  ContactPlistTableViewCell.h
//  AccountManagement
//
//  Created by WeiHu on 15/6/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@class AddressBookDetailInfo;
@class ContactPlistTableViewCell;
typedef void(^PhoneBlock)(ContactPlistTableViewCell *cell__);
@interface ContactPlistTableViewCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *personIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (nonatomic, strong) AddressBookDetailInfo *addressBookDetailInfo;
@property (nonatomic, copy) PhoneBlock phoneBlock;
@end

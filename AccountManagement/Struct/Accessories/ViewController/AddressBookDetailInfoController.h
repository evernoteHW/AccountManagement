//
//  AddressBookDetailInfoController.h
//  AccountManagement
//
//  Created by WeiHu on 15/6/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "BaseViewController.h"
//保存联系人....

typedef NS_ENUM(NSInteger, AddressBookDetailInfoVCType) {
    AddNewContact = 0,     //添加新通讯录
    ModifyContact          //修改通讯录
};


@class AddressBookDetailInfo;
@class MenuItemModel;

typedef void(^TapBlock)(AddressBookDetailInfo *,AddressBookDetailInfoVCType);

@interface AddressBookDetailInfoController : BaseViewController

@property (nonatomic, strong) AddressBookDetailInfo *addressBookDetailInfo;
@property (nonatomic, strong) NSString *groupingType;
@property (nonatomic, copy) TapBlock tapBlcok;

@end

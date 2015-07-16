//
//  MenuItemModel.h
//  AccountManagement
//
//  Created by WeiHu on 15/6/25.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItemModel : BaseDataModel

@property (nonatomic, strong) NSString *menuItemName;
@property (nonatomic, strong) AVRelation *relationFriends;

@end

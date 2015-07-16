//
//  BaseViewController.h
//  PWDManage
//
//  Created by WeiHu on 15/4/14.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;
@class MenuItemModel;
typedef void(^BaseBlock)(id);

@interface BaseViewController : UIViewController
{
    AppDelegate *_appDelegate;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic, strong) MenuItemModel *menuItemModel;

@property (nonatomic, copy) BaseBlock baseBlock;

- (id)storyBoardWithIdentifier:(NSString *)identifier;
@end

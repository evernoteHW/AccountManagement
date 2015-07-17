//
//  DisburseDetailViewController.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "BaseTableViewController.h"
#import "DisburseModel.h"

@interface DisburseDetailViewController : BaseTableViewController

@property (nonatomic, strong)  DisburseModel *disburseModel;

@property (nonatomic, strong) NSString *dataObject;
@end

//
//  DisburseModel.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/16.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "BaseDataModel.h"

@interface DisburseModel : BaseDataModel

@property (nonatomic, strong) NSDate *cureentDate;                     //时间     2015年7月
@property (nonatomic, strong) NSString *parentTime;
@property (nonatomic, strong) NSString *childrTime;
@property (nonatomic, strong) NSString *totalTime;

@property (nonatomic, strong) NSString *timeStr;                //时间
@property (nonatomic, strong) NSString *iconStr;                //
@property (nonatomic, strong) NSString *moneyStr;               //
@property (nonatomic, strong) NSString *accountTypeStr;               //
@property (nonatomic, strong) NSString *categoryStr;            //
@property (nonatomic, strong) NSString *disburseDesStr;         //n
@end

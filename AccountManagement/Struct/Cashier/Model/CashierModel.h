//
//  CashierModel.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/3.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "BaseDataModel.h"
@class CashierDetailModel;

@interface CashierModel : BaseDataModel

@property (nonatomic, strong) NSDate *cureentDate;                     //时间     2015年7月
@property (nonatomic, strong) NSString *parentTime;                    //时间     2015年7月
@property (nonatomic, strong) NSString *childrTime;                    //时间     2015年7月1日
@property (nonatomic, strong) NSString *totalTime;                     //时间     2015年7月1日 13:39 下午

@property (nonatomic, strong) NSString *morningPersons;                 //早班人员
@property (nonatomic, strong) NSString *dinnerPersons;                  //中班人员
@property (nonatomic, strong) NSString *nightPersons;                   //晚班人员

@property (nonatomic, strong) NSString *totalMoney;                     //总额
@property (nonatomic, strong) NSString *deviation;                      //偏差
@property (nonatomic, strong) NSString *sales;                          //销售额
@property (nonatomic, strong) NSString *reservedMoney;                  //预留现金
@property (nonatomic, strong) NSString *comment;                        //备注信息

@end

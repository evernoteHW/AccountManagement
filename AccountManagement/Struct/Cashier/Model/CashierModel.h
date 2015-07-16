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

@property (nonatomic, strong) NSString *cashierTime;                //时间

@property (nonatomic, strong) NSString *morningTotalMoney;          //总额
@property (nonatomic, strong) NSString *morningPersons;              //早班人员
@property (nonatomic, strong) NSString *morningDeviation;           //偏差
@property (nonatomic, strong) NSString *morningSales;              //销售额
@property (nonatomic, strong) NSString *morningReservedMoney;       //销售额
@property (nonatomic, strong) NSString *morningComment;             //备注

@property (nonatomic, strong) NSString *dinnerTotalMoney;          //总额
@property (nonatomic, strong) NSString *dinnerPersons;              //早班人员
@property (nonatomic, strong) NSString *dinnerDeviation;           //偏差
@property (nonatomic, strong) NSString *dinnerSales;              //销售额
@property (nonatomic, strong) NSString *dinnerReservedMoney;       //销售额
@property (nonatomic, strong) NSString *dinnerComment;

@property (nonatomic, strong) NSString *nightTotalMoney;          //总额
@property (nonatomic, strong) NSString *nightPersons;              //早班人员
@property (nonatomic, strong) NSString *nightDeviation;           //偏差
@property (nonatomic, strong) NSString *nightSales;              //销售额
@property (nonatomic, strong) NSString *nightReservedMoney;       //销售额
@property (nonatomic, strong) NSString *nightComment;

@end

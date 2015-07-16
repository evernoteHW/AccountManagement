//
//  CashierTableViewCell.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/3.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashierTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *morningPersonsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningDeviationLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningSalesTLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningTotalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningReservedLabel;


@property (weak, nonatomic) IBOutlet UILabel *dinnerPersonsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dinnerDeviationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dinnerSalesTLabel;
@property (weak, nonatomic) IBOutlet UILabel *mdinnerTotalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dinnerReservedLabel;


@property (weak, nonatomic) IBOutlet UILabel *nightPersonsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightDeviationLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightSalesTLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightTotalMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightReservedLabel;

@property (nonatomic, strong) CashierModel *cashierModel;

@end

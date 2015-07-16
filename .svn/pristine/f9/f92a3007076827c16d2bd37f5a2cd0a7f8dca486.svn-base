//
//  CashierTableViewCell.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/3.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "CashierTableViewCell.h"

@implementation CashierTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setCashierModel:(CashierModel *)cashierModel
{
    _cashierModel = cashierModel;
    
    self.morningPersonsNameLabel.text = _cashierModel.morningPersons;
    self.morningDeviationLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.morningDeviation];
    self.morningSalesTLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.morningSales];
    self.morningTotalMoneyLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.morningTotalMoney];
    self.morningReservedLabel.text = @"-";
    
    self.dinnerPersonsNameLabel.text = _cashierModel.dinnerPersons;
    self.dinnerDeviationLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.dinnerDeviation];
    self.dinnerSalesTLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.dinnerSales];
    self.mdinnerTotalMoneyLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.dinnerTotalMoney];
    self.dinnerReservedLabel.text = @"+";
    
    self.nightPersonsNameLabel.text = _cashierModel.nightPersons;
    self.nightDeviationLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.nightDeviation];
    self.nightSalesTLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.nightSales];
    self.nightTotalMoneyLabel.text = [NSString stringWithFormat:@"¥:%@",_cashierModel.nightTotalMoney];
    self.nightReservedLabel.text = @"+";
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

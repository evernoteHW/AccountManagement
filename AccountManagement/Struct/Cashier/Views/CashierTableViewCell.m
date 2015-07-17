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
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

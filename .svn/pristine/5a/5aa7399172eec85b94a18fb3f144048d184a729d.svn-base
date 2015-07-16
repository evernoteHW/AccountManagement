//
//  OrderTableViewCell.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/4.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setOrderInfoModel:(OrderInfoModel *)orderInfoModel
{
    _orderInfoModel = orderInfoModel;
    _orderStatuesLabel.text = orderInfoModel.orderStatues;
    _orderGoodsNameLabel.text = orderInfoModel.orderName;
    _orderGoodsTypeLabel.text = [NSString stringWithFormat:@"型号:%@",orderInfoModel.orderType];
    _orderGoodsCountLabel.text = [NSString stringWithFormat:@"数量:%@",orderInfoModel.orderCount];
    _orderGoodsPriceLabel.text = [NSString stringWithFormat:@"价格:%.2f/件",[orderInfoModel.orderPrice floatValue]];
    [orderInfoModel.goodsImageViewFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        _orderGoodsImageView.image = [UIImage imageWithData:data];
    }];
    _orderGoodsTimeLabel.text = orderInfoModel.orderKnockdownTime;
    _orderGoodsTotalLabel.text = [NSString stringWithFormat:@"共%@件商品",orderInfoModel.orderCount];
    _orderGoodsTotalPriceLabel.text = [NSString stringWithFormat:@"合计:¥ %.2f",[orderInfoModel.orderPrice floatValue]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

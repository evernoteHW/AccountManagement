//
//  MainfestTableViewCell.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/12.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "MainfestTableViewCell.h"
#import "MainfestModel.h"

@implementation MainfestTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.bastTopLineViewConstraints.constant = 0.5;
    self.leftLineWidthConstraints.constant = 0.5;
    self.rightLineWidthConstraints.constant = 0.5;
    self.topLineHeightConstraints.constant = 0.5;
    self.bottomLineHeighConstraints.constant = 0.5;
}
- (void)setMainfestModel:(MainfestModel *)mainfestModel
{
    _mainfestModel = mainfestModel;
    
    self.nameLabel.text = _mainfestModel.goodsPerson;
    self.goodsCountLabel.text = _mainfestModel.goodsCount;
    self.goodsTypeLabel.text = _mainfestModel.goodsType;
    self.goodsCountLabel.text = [NSString stringWithFormat:@"数量 :%@",_mainfestModel.goodsCount];
    
    [_mainfestModel.goodsImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.goodsTypeImageView.image = [UIImage imageWithData:data];
    }];
    self.goodsTimeLabel.text = @"2015年\n13月01日";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

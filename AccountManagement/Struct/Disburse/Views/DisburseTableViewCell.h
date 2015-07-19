//
//  DisburseTableViewCell.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/13.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisburseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *weakLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *disbureseImageView;
@property (weak, nonatomic) IBOutlet UILabel *disburseTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *disburseMoneyLabel;

@end

//
//  PerformanceDetailTableViewCell.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/19.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerformanceDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *performanceTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *performanceMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *performanceCoefficientLabel;
@end

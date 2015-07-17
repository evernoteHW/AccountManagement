//
//  CustomTitleButton.h
//  AccountManagement
//
//  Created by WeiHu on 15/7/17.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlcok)(id);

@interface CustomTitleView : UIView

@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthBeginAndEndLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMonyLabel;
@property (strong, nonatomic) NSString *timeStr;
@property (copy, nonatomic) TapBlcok tapBlcok;
@end

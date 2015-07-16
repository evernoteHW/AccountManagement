//
//  DetailInfoFlowLayout.h
//  AccountManagement
//
//  Created by WeiHu on 15/6/11.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat verSpacing;
@property (nonatomic, assign) CGFloat horSpacing;

@property (nonatomic, assign) CGFloat cellHeaderHeight;
@end

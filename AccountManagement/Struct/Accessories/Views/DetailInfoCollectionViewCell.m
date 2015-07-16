//
//  DetailInfoCollectionViewCell.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/11.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "DetailInfoCollectionViewCell.h"

@implementation DetailInfoCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UILongPressGestureRecognizer *longGesure = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesureAction)];
    longGesure.numberOfTapsRequired = 1;
    longGesure.minimumPressDuration = 1.0;
    [self addGestureRecognizer:longGesure];
}
- (void)longGesureAction
{

}

@end

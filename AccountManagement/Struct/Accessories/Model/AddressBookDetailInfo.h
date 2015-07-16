//
//  AddressBookDetailInfo.h
//  AccountManagement
//
//  Created by WeiHu on 15/6/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBookDetailInfo : BaseDataModel

@property (nonatomic, strong) NSString * groupingType;          //联系人名称
@property (nonatomic, strong) NSString * contactName;           //联系人名称
@property (nonatomic, strong) NSString * contactNumber;         //联系人号码
@property (nonatomic, strong) AVFile   * contactHeadIcon;        //联系人头像
@property (nonatomic, strong) NSString * contactAddress;        //联系人地址
@property (nonatomic, strong) NSString * otherInfoMsg;          //联系人所属分类

@property (nonatomic, strong) AVRelation *fullResolutionImageRelation;//详情图片的地址
@property (nonatomic, strong) AVRelation *thumbnailImageRelation;      //缩略图片的地址

@end

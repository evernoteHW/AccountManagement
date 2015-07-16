//
//  MainfestModel.h
//  AccountManagement
//
//  Created by WeiHu on 15/6/27.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "BaseDataModel.h"

@interface MainfestModel : BaseDataModel

@property (nonatomic, strong) NSString * goodsDateStr;          //联系人名称
@property (nonatomic, strong) NSString * goodsPerson;           //拿货人
@property (nonatomic, strong) NSString * goodsType;             //品类
@property (nonatomic, strong) AVFile   * goodsImageFile;        //商品图片
@property (nonatomic, strong) NSString * goodsCount;            //商品数量
@property (nonatomic, strong) NSString * goodsPrice;            //商品进货价

@property (nonatomic, strong) NSString *goodsMerchantStr;       //进货商人
@property (nonatomic, strong) NSString *goodsPickUpAddressStr;  //进货地址
@property (nonatomic, strong) NSString *goodsNameStr;           //商品名称
@property (nonatomic, strong) NSString *goodsCountStr;          //商品数量
@property (nonatomic, strong) NSString *goodsPriceStr;          //商品价格
@property (nonatomic, strong) NSString *moneyAmountStr;         //兑额比
@property (nonatomic, strong) NSString *retailPercentStr;
@property (nonatomic, strong) NSString *profitsPercentStr;      //利润比

@end

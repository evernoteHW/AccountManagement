//
//  OrderDetailViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/4.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orderStatuesLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPersonsLabel;
@property (weak, nonatomic) IBOutlet UITextField *orderNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *orderTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *orderCountTextField;
@property (weak, nonatomic) IBOutlet UIImageView *orderGoodsImageView;
@property (weak, nonatomic) IBOutlet UITextField *orderPriceTextField;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderKnockdownTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderModifyTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *orderConmmentTextView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.orderStatuesLabel.text = self.orderInfoModel.orderStatues;
    self.orderPersonsLabel.text = self.orderInfoModel.orderPersons;
    self.orderNameTextField.text = self.orderInfoModel.orderName;
    self.orderTypeTextField.text = self.orderInfoModel.orderType;
    self.orderCountTextField.text = self.orderInfoModel.orderCount;
    self.orderPriceTextField.text = self.orderInfoModel.orderPrice;
    self.orderNumberLabel.text = self.orderInfoModel.objectId;
    self.orderKnockdownTimeLabel.text = [NSDate getTimeStr1:[self.orderInfoModel.createdAt timeIntervalSince1970]];
    self.orderModifyTimeLabel.text = [NSDate getTimeStr1:[self.orderInfoModel.updatedAt timeIntervalSince1970]];
    self.orderConmmentTextView.text = self.orderInfoModel.orderConmment;
    
    [self.orderInfoModel.goodsImageViewFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.orderGoodsImageView.image = [UIImage imageWithData:data];
    }];

}
- (IBAction)statuesInfoBtnAction:(UIButton *)sender {
    CGPoint point = [sender convertPoint:sender.bounds.origin toView:[UIApplication sharedApplication].keyWindow];
    NSArray *titles = @[@"已支付", @"已取消", @"已失效"];
    
    CGPoint point0 = CGPointMake(point.x + sender.bounds.size.width / 2.0, point.y + sender.bounds.size.height + 10);
    
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point0 titles:titles images:nil];
    pop.selectRowAtIndex = ^(NSString * content){
        self.orderStatuesLabel.text = content;
    };
    [pop show];
    
}
- (IBAction)personSelectedBtnAction:(UIButton *)sender {
    CGPoint point = [sender convertPoint:sender.bounds.origin toView:[UIApplication sharedApplication].keyWindow];
    NSArray *titles = @[@"A", @"B", @"C"];
    
    CGPoint point0 = CGPointMake(point.x + sender.bounds.size.width / 2.0, point.y + sender.bounds.size.height + 10);
    
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point0 titles:titles images:nil];
    pop.selectRowAtIndex = ^(NSString * content){
        self.orderPersonsLabel.text = content;
    };
    [pop show];

}
- (IBAction)saveOrderDetailInfoBtnAction:(UIButton *)sender {
    
    NSInteger flagtype = 0;
    if (self.orderInfoModel) {
        flagtype = 0;
    }else
    {
        flagtype = 1;
        self.orderInfoModel = [OrderInfoModel BD_Create];
    }
    self.orderInfoModel.orderStatues = self.orderStatuesLabel.text;
    self.orderInfoModel.orderPersons = self.orderPersonsLabel.text;
    self.orderInfoModel.orderName = self.orderNameTextField.text;
    self.orderInfoModel.orderType = self.orderTypeTextField.text;
    self.orderInfoModel.orderCount = self.orderCountTextField.text;
    self.orderInfoModel.orderPrice = self.orderPriceTextField.text;
    self.orderInfoModel.orderNumber = self.orderNumberLabel.text;
    self.orderInfoModel.orderKnockdownTime = self.orderKnockdownTimeLabel.text;
    self.orderInfoModel.orderModifyTime = self.orderModifyTimeLabel.text;
    self.orderInfoModel.orderConmment = self.orderConmmentTextView.text;
    
    AVFile *file = [AVFile fileWithName:@"demo.png" data:UIImagePNGRepresentation([UIImage imageNamed:@"sousuo_illustration"])];
    self.orderInfoModel.goodsImageViewFile = file;
    

    [self.orderInfoModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            self.menuItemModel.relationFriends = [self.menuItemModel relationforKey:kOrderInfoModelRelationShips];
            [self.menuItemModel.relationFriends addObject:self.orderInfoModel];
            
            [self.menuItemModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    if (self.baseBlock) {
                        self.baseBlock(self.orderInfoModel);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
    }];
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

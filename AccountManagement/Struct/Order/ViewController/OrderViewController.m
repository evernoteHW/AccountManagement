
//
//  OrderViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/4.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"

@interface OrderViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *orderTableView;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getOrderListData];
}
- (void)getOrderListData
{
    AVRelation *avRelation = [self.menuItemModel objectForKey:kOrderInfoModelRelationShips];
    
    
    [[avRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {

        } else {
            [self.dataArray addObjectsFromArray:objects];

            [self.orderTableView reloadData];
        }
    }];

}

- (IBAction)orderDetailBtnAction:(UIButton *)sender {
    
    OrderDetailViewController *vc = (OrderDetailViewController *)[self storyBoardWithIdentifier:@"OrderDetailViewController"];
    vc.menuItemModel = self.menuItemModel;
    
    OrderViewController *__weak weakSelf = self;
    vc.baseBlock = ^(id content){
        OrderViewController *strongSelf = weakSelf;
        if (content) {
            [self.dataArray addObject:content];
        }
        [strongSelf.orderTableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
    cell.orderInfoModel = self.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailViewController *vc = (OrderDetailViewController *)[self storyBoardWithIdentifier:@"OrderDetailViewController"];
    vc.menuItemModel = self.menuItemModel;
    vc.orderInfoModel = self.dataArray[indexPath.row];
    OrderViewController *__weak weakSelf = self;
    vc.baseBlock = ^(id content){
        OrderViewController *strongSelf = weakSelf;
        [strongSelf.orderTableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
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

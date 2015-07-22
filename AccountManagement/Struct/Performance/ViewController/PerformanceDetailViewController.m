//
//  PerformanceDetailViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/19.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "PerformanceDetailViewController.h"
#import "TableHeaderView.h"
#import "PerformanceDetailTableViewCell.h"

@interface PerformanceDetailViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *employArray;
}
@property (weak, nonatomic) IBOutlet UITableView *performanceTableView;
@end

@implementation PerformanceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    employArray = @[@"小敏",@"红姐",@"小鱼儿和英米"];
    self.performanceTableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}
- (IBAction)addPerformanceAction:(UIBarButtonItem *)sender {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return employArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    TableHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil].lastObject;
    headerView.employerNameLabel.text = employArray[section];
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfier = @"PerformanceDetailViewControllerCell";
    PerformanceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (indexPath.row == 0) {
        
        cell.performanceTypeLabel.text = @"化妆品";
        cell.performanceMoneyLabel.text = @"¥ 5500.00";
        cell.performanceCoefficientLabel.text = @"0.3";
        
    }else if (indexPath.row == 1) {
        cell.performanceTypeLabel.text = @"包包";
        cell.performanceMoneyLabel.text = @"¥ 1500.00";
        cell.performanceCoefficientLabel.text = @"0.4";
    }else if (indexPath.row == 2) {
        cell.performanceTypeLabel.text = @"礼品";
        cell.performanceMoneyLabel.text = @"¥ 8500.00";
        cell.performanceCoefficientLabel.text = @"0.2";
    }else if (indexPath.row == 3) {
        cell.performanceTypeLabel.text = @"饰品";
        cell.performanceMoneyLabel.text = @"¥ 9500.00";
        cell.performanceCoefficientLabel.text = @"0.7";
    }


    return cell;
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

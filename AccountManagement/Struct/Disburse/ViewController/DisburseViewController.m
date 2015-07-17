//
//  DisburseViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/7/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "DisburseViewController.h"
#import "DisburseDetailViewController.h"
#import "DisburseTableViewCell.h"
#import<CoreText/CoreText.h>
#import "CustomTitleView.h"

@interface DisburseViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *disbuseTableView;

@end

@implementation DisburseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (NSInteger i = [NSDate getCureentMonth]; i > 0; i--) {
        [self.dataArray addObject:@{[NSString stringWithFormat:@"%ld_%02ld",[NSDate getCureentYear],i]:[@[] mutableCopy]}];
    }
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = self.dataArray[section];
    NSArray *arr = dic[dic.allKeys.firstObject];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DisburseTableViewSubCell";
    DisburseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
//    cell.monthLabel.text = @(self.dataArray.count - indexPath.row).stringValue ;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CustomTitleView *customTitleView = [[NSBundle mainBundle] loadNibNamed:@"CustomTitleView" owner:self options:nil].lastObject;
    customTitleView.tag = section;
    NSDictionary *dic = self.dataArray[section];
    customTitleView.monthLabel.text = dic.allKeys.firstObject;
    customTitleView.timeStr = dic.allKeys.firstObject;
    
    customTitleView.tapBlcok = ^(CustomTitleView *customTitleView__){
        
        AVRelation *avRelation = [self.menuItemModel objectForKey:[NSString stringWithFormat:@"DisburseShips%@",customTitleView__.timeStr]];
        [[avRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                
            } else {
                NSMutableArray *arr = nil;
                for (NSDictionary *dic in self.dataArray) {
                    if ([dic.allKeys.firstObject isEqualToString:customTitleView__.timeStr]) {
                        arr = dic[dic.allKeys.firstObject];
                        break;
                    }
                }
                
                for (DisburseModel *model in objects) {
                    [arr addObject:model];
                }
                
                [self.disbuseTableView reloadData];
                
            }
        }];
    };
  
    return customTitleView;
}


- (void)titleBtnAction:(UIButton *)btn
{
    //删除数据
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击cell后 改变cell的颜色 渐变
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}
- (IBAction)addDisburseBtnAction:(id)sender {
    
    DisburseDetailViewController *vc = [self storyBoardWithIdentifier:@"DisburseDetailViewController"];
    vc.menuItemModel = self.menuItemModel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getMonthDataWithTime:(NSString *)timeStr
{
    //查询

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

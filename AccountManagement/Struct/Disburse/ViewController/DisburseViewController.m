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

@interface DisburseViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *disbuseTableView;

@end

@implementation DisburseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSCalendar * calendar= [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitHour|NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents * component=[calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger month = [component month];
    
    for (NSInteger i = 1; i < month; i++) {
        [self.dataArray addObject:@(i)];
    }
    //请求一个大组...............
    
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DisburseTableViewCell";
    DisburseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.monthLabel.text = @(self.dataArray.count - indexPath.row).stringValue ;
    
    return cell;
    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 44);
    [titleBtn setTitle:@"点击展开" forState:UIControlStateNormal];
    return titleBtn;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击cell后 改变cell的颜色 渐变
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
}

- (void)getMonthDataWithTime:(NSString *)timeStr
{
    //查询
    AVRelation *avRelation = [self.menuItemModel objectForKey:[NSString stringWithFormat:@"Disburse_%@",timeStr]];
    [[avRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {

        } else {
            NSMutableArray *smallerArray = nil;
//            for (AddressBookDetailInfo *addressBookDetailInfo in objects) {
//                //重新分组
//                //                NSLog(@"%@",addressBookDetailInfo.groupingType);
//                BOOL isFind = NO;
//                for (NSDictionary *dic in dataArray) {
//                    if ([dic.allKeys.firstObject isEqualToString:addressBookDetailInfo.groupingType]) {
//                        [dic.allValues.firstObject addObject:addressBookDetailInfo];
//                        //跳出循环
//                        isFind = YES;
//                        break;
//                    }
//                }
//                if (!isFind) {
//                    smallerArray = [NSMutableArray array];
//                    [smallerArray addObject:addressBookDetailInfo];
//                    [dataArray  addObject:@{addressBookDetailInfo.groupingType:smallerArray}];
//                }
//                
//            }
//            [self.contactPlistTableView reloadData];

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

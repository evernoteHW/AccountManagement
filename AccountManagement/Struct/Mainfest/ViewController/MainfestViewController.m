//
//  MainfestViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/12.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "MainfestViewController.h"
#import "MainfestTableViewCell.h"
#import "MainfestDetailInfoViewController.h"
#import "MainfestModel.h"
#import "MenuItemModel.h"

@interface MainfestViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *mainFestDataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *mainfestTableView;
@end

@implementation MainfestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mainFestDataArray = [NSMutableArray array];
    

    [self getMainfestData];

}

- (void)getMainfestData
{
    
    AVRelation *avRelation = [self.menuItemModel objectForKey:@"MainfestDetailInfoRelationShips"];
    [[avRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {

        } else {
            for (MainfestModel *mainfestModel in objects) {
                [mainFestDataArray addObject:mainfestModel];
//                NSLog(@"%f",[mainfestModel.createdAt timeIntervalSince1970]);
            }
            [self.mainfestTableView reloadData];

        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainFestDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainfestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainfestViewControllerCell"];
    cell.mainfestModel = mainFestDataArray[indexPath.row];    
    return cell;
}
- (IBAction)addNewMainfestBtnAction:(id)sender {
    
    MainfestDetailInfoViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainfestDetailInfoViewController"];
    vc.menuItemModel = self.menuItemModel;
    vc.tapBlock = ^(MainfestModel *mainfestModel__){
        if (![mainFestDataArray containsObject:mainfestModel__]) {
            [mainFestDataArray addObject:mainfestModel__];
        }
        [self.mainfestTableView reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainfestDetailInfoViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainfestDetailInfoViewController"];
    vc.mainfestModel = mainFestDataArray[indexPath.row];
    vc.menuItemModel = self.menuItemModel;
    vc.tapBlock = ^(MainfestModel *mainfestModel__){
     
        if (![mainFestDataArray containsObject:mainfestModel__]) {
            [mainFestDataArray addObject:mainfestModel__];
        }
        [self.mainfestTableView reloadData];
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

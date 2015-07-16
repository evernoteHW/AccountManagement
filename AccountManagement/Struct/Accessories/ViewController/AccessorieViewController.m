//
//  AccessorieViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/9.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "AccessorieViewController.h"
#import "FlowCollectionViewCell.h"
#import "UIColor+Extension.h"
#import "ContactPlistViewController.h"
#import "MainfestViewController.h"
#import "UserLoginModel.h"
#import "MenuItemModel.h"
#import "DetailInfoFlowLayout.h"
#import "CashierViewController.h"
#import "OrderViewController.h"
#import "DisburseViewController.h"


@interface AccessorieViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *colorArray;
    NSArray *imagesArray;
    NSMutableArray *menuItemArray;
}
@property (weak, nonatomic) IBOutlet UICollectionView *accessorieCollectionView;
@end

@implementation AccessorieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    colorArray = @[kRGB(192,235,246),kRGB(164,212,225),kRGB(245,120,73),kRGB(237,205,122),kRGB(255,103,148),kRGB(187,228,238)];
    imagesArray = @[@"addressbook",@"invoice",@"order",@"cashier",@"performance",@"spending"];
    menuItemArray = [NSMutableArray array];
    
    [self initLayout];
    
    [self getMenuItemListData];
    
}
- (void)initLayout
{
    [super awakeFromNib];
    
    DetailInfoFlowLayout *layout = (DetailInfoFlowLayout *)self.accessorieCollectionView.collectionViewLayout;
    layout.verSpacing = 10;
    layout.horSpacing = 0;
    layout.cellHeaderHeight = 200;
    layout.cellWidth = ([UIApplication sharedApplication].keyWindow.frame.size.width - 4 * layout.verSpacing)/ 3.0 ;
    layout.cellHeight = 130;
}

- (void)getMenuItemListData
{

    AVRelation *avRelation = [[UserLoginModel currentUser] objectForKey:@"menuItemNameArr"];
    [[avRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {

        } else {
            for (MenuItemModel *menuItemModel in objects) {
                
                if (menuItemArray.count < 6) {
                    [menuItemArray addObject:menuItemModel];
                }
            };
            [self.accessorieCollectionView reloadData];

        }
    }];
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return menuItemArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlowCollectionViewCell" forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:imagesArray[indexPath.row]];
    MenuItemModel *menuItemModel = menuItemArray[indexPath.row];
    cell.titleLabel.text = menuItemModel.menuItemName;
    cell.pinkBackgroundView.backgroundColor = colorArray[indexPath.row];
    
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AccessorieHeaderView" forIndexPath:indexPath];
        
        return view;
    }
    return [UICollectionReusableView new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ContactPlistViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ContactPlistViewController"];
            vc.menuItemModel = menuItemArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            MainfestViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainfestViewController"];
            vc.menuItemModel = menuItemArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            OrderViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderViewController"];
            vc.menuItemModel = menuItemArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            CashierViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CashierViewController"];
            vc.menuItemModel = menuItemArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            DisburseViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DisburseViewController"];
            vc.menuItemModel = menuItemArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
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

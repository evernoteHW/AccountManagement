//
//  ContactPlistViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "ContactPlistViewController.h"
#import "ContactPlistTableViewCell.h"
#import <AddressBook/AddressBook.h>
#import "UIColor+Extension.h"
#import "AddressBookDetailInfo.h"
#import "AddressBookDetailInfoController.h"
#import "MenuItemModel.h"


@interface ContactPlistViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SWTableViewCellDelegate>
{
    NSMutableArray *dataArray;
    NSArray *filterData;
}
@property (weak, nonatomic) IBOutlet UITableView *contactPlistTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *contactSerachBar;
@end;

@implementation ContactPlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataArray = [NSMutableArray array];
    [self getContactPListData];
    
}

- (void)getContactPListData
{

    AVRelation *avRelation = [self.menuItemModel objectForKey:@"AddressBookEntityRelationShips2"];
    [[avRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {

        } else {
            NSMutableArray *smallerArray = nil;
            for (AddressBookDetailInfo *addressBookDetailInfo in objects) {
                //重新分组
//                NSLog(@"%@",addressBookDetailInfo.groupingType);
                BOOL isFind = NO;
                for (NSDictionary *dic in dataArray) {
                    if ([dic.allKeys.firstObject isEqualToString:addressBookDetailInfo.groupingType]) {
                        [dic.allValues.firstObject addObject:addressBookDetailInfo];
                        //跳出循环
                        isFind = YES;
                        break;
                    }
                }
                if (!isFind) {
                    smallerArray = [NSMutableArray array];
                    [smallerArray addObject:addressBookDetailInfo];
                    [dataArray  addObject:@{addressBookDetailInfo.groupingType:smallerArray}];
                }
              
            }
            [self.contactPlistTableView reloadData];

        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.contactPlistTableView) {
        return dataArray.count;
    }else{
        // 谓词搜索
        return filterData.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = dataArray[section];
    NSArray *arr = dic[dic.allKeys.firstObject];
    return arr.count  + 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
    NSDictionary *dic  = dataArray[section];
    titleLabel.text = [NSString stringWithFormat:@"     %@",dic.allKeys.firstObject];
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return titleLabel;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    
    if (tableView == self.contactPlistTableView) {
        NSDictionary *dic = dataArray[indexPath.section];
        NSArray *arr = dic[dic.allKeys.firstObject];

        if (arr.count  == indexPath.row) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactPlistViewControllerNoneCell" ];
            return cell;
        }else{
            ContactPlistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactPlistViewControllerCell" ];
            cell.addressBookDetailInfo = arr[indexPath.row];
            
       
            
            if (!cell.rightUtilityButtons) {
                cell.delegate = self;
                cell.rightUtilityButtons = [self rightButtons];
            }
            if (!cell.phoneBlock) {
                
                cell.phoneBlock = ^(ContactPlistTableViewCell *cell__){
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",cell__.addressBookDetailInfo.contactNumber]]];
                };
            }
            return cell;
        }
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactPlistViewControllerSearchCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContactPlistViewControllerSearchCell"];
        }
//        cell.textLabel.text = filterData[0];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (tableView == self.contactPlistTableView) {
         
         AddressBookDetailInfoController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddressBookDetailInfoController"];
         NSDictionary *dic = dataArray[indexPath.section];
         NSArray *arr = dic[dic.allKeys.firstObject];
         vc.groupingType = dic.allKeys.firstObject;
         
         if (arr.count  == indexPath.row) {
         }else{
             vc.addressBookDetailInfo = arr[indexPath.row];
             NSLog(@"%@",vc.addressBookDetailInfo.objectId);
         }
         vc.menuItemModel = self.menuItemModel;
         vc.tapBlcok = ^(AddressBookDetailInfo *addressBookDetailInfo__,AddressBookDetailInfoVCType addressBookDetailInfoVCType__ ){
             // 刷新下页面
             switch (addressBookDetailInfoVCType__) {
                 case AddNewContact:
                 {
                         //重新分组
                     BOOL isFind = NO;
                     for (NSDictionary *dic in dataArray) {
                         if ([dic.allKeys.firstObject isEqualToString:addressBookDetailInfo__.groupingType]) {
                             [dic.allValues.firstObject addObject:addressBookDetailInfo__];
                             //跳出循环
                             isFind = YES;
                             break;
                         }
                     }
                     if (!isFind) {
                         NSMutableArray *smallerArray = [NSMutableArray array];
                         [smallerArray addObject:addressBookDetailInfo__];
                         [dataArray  addObject:@{addressBookDetailInfo__.groupingType:smallerArray}];
                     }
                 }
                     break;
                 case ModifyContact:
                 {
                     
                 }
                     break;
                     
                 default:
                     break;
             }
           
             [self.contactPlistTableView reloadData];
             
         };
         [self.navigationController pushViewController:vc animated:YES];
     }

}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
        
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"编辑"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}

- (void)ReadAllPeoples
{
    
    //取得本地通信录名柄
    
    ABAddressBookRef tmpAddressBook = nil;
    
    tmpAddressBook=ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

    //取得本地所有联系人记录
    
    
    if (tmpAddressBook==nil) {
        return ;
    };
    NSArray* tmpPeoples = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
    
    for(id tmpPerson in tmpPeoples)
        
    {
        
        //获取的联系人单一属性:First name
        
        NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        
        NSLog(@"First name:%@", tmpFirstName);
        

        //获取的联系人单一属性:Last name
        
        NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
        
        NSLog(@"Last name:%@", tmpLastName);
        
        
        //获取的联系人单一属性:Nickname
        
        NSString* tmpNickname = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonNicknameProperty);
        
        NSLog(@"Nickname:%@", tmpNickname);
        
        //获取的联系人单一属性:Company name
        
        NSString* tmpCompanyname = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonOrganizationProperty);
        
        NSLog(@"Company name:%@", tmpCompanyname);
        
        
        //获取的联系人单一属性:Job Title
        
        NSString* tmpJobTitle= (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonJobTitleProperty);
        
        NSLog(@"Job Title:%@", tmpJobTitle);
        
        
        //获取的联系人单一属性:Department name
        
        NSString* tmpDepartmentName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonDepartmentProperty);
        
        NSLog(@"Department name:%@", tmpDepartmentName);
        
        
        //获取的联系人单一属性:Birthday
        
        NSDate* tmpBirthday = (__bridge NSDate*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonBirthdayProperty);
        
        NSLog(@"Birthday:%@", tmpBirthday);
        
        
        //获取的联系人单一属性:Note
        
        NSString* tmpNote = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonNoteProperty);
        
        NSLog(@"Note:%@", tmpNote);
        
        
        //获取的联系人单一属性:Generic phone number
        
        ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
        
        for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
            
        {
            
            NSString* tmpPhoneIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
            
            NSLog(@"tmpPhoneIndex%ld:%@", (long)j, tmpPhoneIndex);
        
            
        }
        CFRelease(tmpPhones);
    }
    //释放内存
    CFRelease(tmpAddressBook);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

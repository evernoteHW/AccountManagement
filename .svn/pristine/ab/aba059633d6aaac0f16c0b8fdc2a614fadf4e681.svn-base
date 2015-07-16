//
//  MainfestDetailInfoViewController.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/12.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "MainfestDetailInfoViewController.h"
#import "MainfestModel.h"
#import "MenuItemModel.h"

@interface MainfestDetailInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate>
{
    NSArray *tempArray ;
    CGFloat height;
}
@property (weak, nonatomic) IBOutlet UITextField *goodsTimeTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *goodsPickUpTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *goodsPickUpAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *goodsTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *goodsNameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *goodsMerchantTextField;
@property (weak, nonatomic) IBOutlet UITextField *goodsCountTextField;
@property (weak, nonatomic) IBOutlet UITextField *goodsPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *moneyAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *retailPercentTextField;
@property (weak, nonatomic) IBOutlet UITextField *profitsPercentTextField;
@property (weak, nonatomic) IBOutlet UIView *leftCornerView;

@property (weak, nonatomic) IBOutlet UIView *centerCornerView;
@property (weak, nonatomic) IBOutlet UIView *rightCornerView;

@property (weak, nonatomic) IBOutlet UIImageView *personImageView;

@end

@implementation MainfestDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftCornerView.layer.borderColor = [UIColor colorWithR:252 G:85 B:112].CGColor;
     self.centerCornerView.layer.borderColor = [UIColor colorWithR:252 G:85 B:112].CGColor;
     self.rightCornerView.layer.borderColor = [UIColor colorWithR:252 G:85 B:112].CGColor;
    self.personImageView.layer.borderColor = [[UIColor groupTableViewBackgroundColor] colorWithAlphaComponent:.8].CGColor;
}
- (IBAction)saveBtnAction:(id)sender {
    //新添加一条........
    if (self.mainfestModel) {
     
        
    }else{
        self.mainfestModel = [MainfestModel BD_Create];
    }
    self.mainfestModel.goodsDateStr = self.goodsNameTextFiled.text;
    self.mainfestModel.goodsPerson = self.goodsPickUpTextFiled.text;
    self.mainfestModel.goodsType = self.goodsTypeTextField.text;
    self.mainfestModel.goodsCount = self.goodsCountTextField.text;
    self.mainfestModel.goodsPrice = self.goodsPriceTextField.text;
    self.mainfestModel.goodsMerchantStr = self.goodsMerchantTextField.text;
    self.mainfestModel.goodsPickUpAddressStr = self.goodsPickUpAddressTextField.text;
    self.mainfestModel.goodsNameStr = self.goodsNameTextFiled.text;
    self.mainfestModel.goodsCountStr = self.goodsCountTextField.text;
    self.mainfestModel.goodsPriceStr = self.goodsPriceTextField.text;
    self.mainfestModel.retailPercentStr = self.retailPercentTextField.text;
    self.mainfestModel.profitsPercentStr = self.profitsPercentTextField.text;
    
    AVFile *file = [AVFile fileWithName:@"demo.png" data:UIImagePNGRepresentation([UIImage imageNamed:@"sousuo_illustration"])];
    self.mainfestModel.goodsImageFile = file;
    
    
    [self.mainfestModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            self.menuItemModel.relationFriends = [self.menuItemModel relationforKey:@"MainfestDetailInfoRelationShips"];
            [self.menuItemModel.relationFriends addObject:self.mainfestModel];
            
            [self.menuItemModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (self.tapBlock) {
                    self.tapBlock(self.mainfestModel);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
     
    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.mainfestModel.
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
//    [self.tableView beginUpdates];
    
//    CGFloat fixedWidth = textView.frame.size.width;
//    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    CGRect newFrame = textView.frame;
//    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), fmaxf(120, newSize.height));
//    textView.frame = newFrame;
//    height = newFrame.size.height;
//    
//    [self.tableView endUpdates];
//    
//    NSLog(@"%f",newFrame.size.height);
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
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

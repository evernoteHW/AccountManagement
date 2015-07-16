//
//  AddressBookDetailInfoController.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "AddressBookDetailInfoController.h"
#import "AddressBookDetailInfo.h"
#import "UIActionSheet+Blocks.h"
#import "UIPlaceHolderTextView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "CTAssetsPickerController.h"
#import "MenuItemModel.h"
#import "DetailInfoCollectionViewCell.h"
#import "UIAlertView+Blocks.h"
#import "DetailInfoFlowLayout.h"

@interface AddressBookDetailInfoController ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,CTAssetsPickerControllerDelegate>
{
    BOOL isChangeHeadIcon;
}
@property (nonatomic, strong) NSMutableArray *photosArray;
@property (nonatomic, strong) NSMutableArray *avFilePhotosArray;

@property (weak, nonatomic) IBOutlet UIImageView *headIconImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (weak, nonatomic) IBOutlet UILabel *belongingrRegionLabel;

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *addressTextView;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *categoryTextView;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *detailInfoCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailInfoHeightConstraint;
@end

@implementation AddressBookDetailInfoController
- (NSMutableArray *)photosArray
{
    if (!_photosArray) {
        _photosArray = [NSMutableArray array];
    }
       return _photosArray;
}
- (NSMutableArray *)avFilePhotosArray
{
    if (!_avFilePhotosArray) {
        _avFilePhotosArray = [NSMutableArray array];
    }
    return _avFilePhotosArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addressTextView.placeholder = @"请输入地址";
    self.categoryTextView.placeholder = @"请输入品类";
    
    if (self.addressBookDetailInfo) {
        [self.addressBookDetailInfo.contactHeadIcon getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            self.headIconImageView.image = [UIImage imageWithData:data];
        }];
        self.nameTextField.text = self.addressBookDetailInfo.contactName;
        self.numberTextField.text = self.addressBookDetailInfo.contactNumber;
        self.addressTextView.text = self.addressBookDetailInfo.contactAddress;
        self.categoryTextView.text = self.addressBookDetailInfo.groupingType;
        
        AVRelation *avRelation = [self.addressBookDetailInfo objectForKey:@"FullResolutionImageRelationShips"];
        
        [[avRelation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {

            } else {
                for (AVObject *avobjet  in objects) {
                    AVFile *file = [avobjet objectForKey:@"image"];
                    [self.avFilePhotosArray addObject:file];
                    [self.photosArray addObject:[UIImage imageWithData:[file getData]]];
                }
                [self.detailInfoCollectionView reloadData];

            }
        }];

        
        //获取号码归属地
        [[NetworkManager shareManager] requestWithURL:@"http://tcc.taobao.com/cc/json/mobile_tel_segment.htm" params:[@{@"tel":self.numberTextField.text} mutableCopy] httpMethod:@"GET" finishBlock:^(DataServies *request, id result) {
            self.belongingrRegionLabel.text = [NSString stringWithFormat:@"%@  %@",result[@"province"],result[@"catName"]];
            
        } failBlock:^(DataServies *request, NSError *error) {
            
        }];
    }
    [self initFlowLayout];
}

- (void)initFlowLayout
{
    [super awakeFromNib];
    
    DetailInfoFlowLayout *layout = (DetailInfoFlowLayout *)self.detailInfoCollectionView.collectionViewLayout;
    layout.verSpacing = 10;
    layout.horSpacing = 10;
    layout.cellHeaderHeight = 0;
    layout.cellWidth = ([UIApplication sharedApplication].keyWindow.frame.size.width - 4 * layout.verSpacing - 40)/ 3.0 ;
    layout.cellHeight = layout.cellWidth;
}
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    self.containerViewHeightConstraint.constant = MAX([UIApplication sharedApplication].keyWindow.frame.size.height + 1, self.saveBtn.frame.origin.y + self.saveBtn.frame.size.height + 20);
    
    CGRect addRessTextViewNewFrame =  [self autoLayoutWithTextView:self.addressTextView];
    CGRect categoryTextViewNewFrame  = [self autoLayoutWithTextView:self.categoryTextView];
    
    self.detailInfoHeightConstraint.constant = 10 + (5 + (self.detailInfoCollectionView.frame.size.width - 40 ) / 3.0 + 5) * (self.photosArray.count/3 + 1);
    
    self.containerViewHeightConstraint.constant = MAX([UIApplication sharedApplication].keyWindow.frame.size.height + 1, addRessTextViewNewFrame.size.height + categoryTextViewNewFrame.size.height + self.detailInfoHeightConstraint.constant + 400);
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (IBAction)saveBtnAction:(UIButton *)sender {
    AddressBookDetailInfoVCType type ;
    if (self.addressBookDetailInfo) {
        type = ModifyContact; 
        
    }else
    {
        self.addressBookDetailInfo = [AddressBookDetailInfo BD_Create];
        type = AddNewContact;
    }
    //图片是否修改
    self.addressBookDetailInfo.contactName = self.nameTextField.text;
    AVFile *file = [AVFile fileWithName:@"demo.png" data:UIImagePNGRepresentation(self.headIconImageView.image)];
    self.addressBookDetailInfo.contactHeadIcon = file;
    self.addressBookDetailInfo.contactNumber = self.numberTextField.text;
    self.addressBookDetailInfo.contactAddress = self.addressTextView.text;
    self.addressBookDetailInfo.groupingType = self.groupingType;
//    self.addressBookDetailInfo.fullResolutionImageRelation = 
    switch (type) {
        case AddNewContact:
        {
            [self.addressBookDetailInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    
                    self.menuItemModel.relationFriends = [self.menuItemModel relationforKey:@"AddressBookEntityRelationShips2"];
                    [self.menuItemModel.relationFriends addObject:self.addressBookDetailInfo];
                    [self.menuItemModel saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            if (self.tapBlcok) {
                                self.tapBlcok(self.addressBookDetailInfo,type);
                            }
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    }];
                    
                 
                }
            }];
          
        }
            break;
        case ModifyContact:
        {
            [self.addressBookDetailInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    if (self.tapBlcok) {
                        self.tapBlcok(self.addressBookDetailInfo,type);
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            
        }
            break;
            
        default:
            break;
    }


}
- (IBAction)changeHeadIconAction:(id)sender {
    
    isChangeHeadIcon = YES;
    
    [UIActionSheet showInView:self.view
                    withTitle:nil
            cancelButtonTitle:@"取消"
       destructiveButtonTitle:nil
            otherButtonTitles:@[@"从手机相册选择", @"拍照"]
                     tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                         if (buttonIndex == [actionSheet cancelButtonIndex]) {
                             
                         } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"从手机相册选择"]) {
                             [self selectFromAlbum];
                         } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"拍照"]) {
                             
                         }
                     }];

}

- (IBAction)tapGestureAction:(UITapGestureRecognizer *)sender {
   
    isChangeHeadIcon = NO;
    
    CGPoint location = [sender locationInView:self.detailInfoCollectionView];
    NSIndexPath *indexPath = [self.detailInfoCollectionView indexPathForItemAtPoint:location];
    
    if (indexPath) {
        NSLog(@"Cell view was tapped.");
//        UICollectionViewCell *cell = [self.detailInfoCollectionView cellForItemAtIndexPath:indexPath];
        
        if (indexPath.row == self.photosArray.count) {
            
            [UIActionSheet showInView:self.view
                            withTitle:nil
                    cancelButtonTitle:@"取消"
               destructiveButtonTitle:nil
                    otherButtonTitles:@[@"从手机相册选择", @"拍照"]
                             tapBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
                                 if (buttonIndex == [actionSheet cancelButtonIndex]) {
                                     
                                 } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"从手机相册选择"]) {
                                     [self selectFromAlbum];
                                 } else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"拍照"]) {
                                     
                                 }
                             }];

        }else{
            
            
        }
    }else{
       [self.view endEditing:YES];
    }
}

#pragma mark -
#pragma mark - Image picker

- (void)selectFromAlbum
{
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
    {
        [UIAlertView showWithTitle:@"请在【设置->隐私->照片】中，允许访问您的相册"
                           message:nil
                 cancelButtonTitle:@"确定"
                 otherButtonTitles:nil
                          tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                        
                          }];

    }
    
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    picker.assetsFilter         = [ALAssetsFilter allAssets];
    picker.showsCancelButton    = (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad);
    picker.delegate             = self;
    picker.selectedAssets       = [NSMutableArray array];
    
    [picker.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [picker.navigationController.navigationBar setTitleTextAttributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15.0f],
                                                                         NSForegroundColorAttributeName : [UIColor whiteColor]}];



    [self presentViewController:picker animated:YES completion:nil];

}

- (void)selectFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted)
        {
            [UIAlertView showWithTitle:@"请在【设置->隐私->照片】中，允许访问您的相册"
                               message:nil
                     cancelButtonTitle:@"确定"
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  
                              }];
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - Assets Picker Delegate

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group
{
    return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{

    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if (isChangeHeadIcon) {
        self.headIconImageView.image = [UIImage imageWithCGImage:[assets[0] thumbnail]];
    }else{
        for (ALAsset *asset in assets) {
            //通过ALAsset获取相对应的资源，获取图片的等比缩略图，原图的等比缩略
            //        CGImageRef ratioThum = [asset aspectRatioThumbnail];
            //获取相片的缩略图，该缩略图是相册中每张照片的poster图
            //        CGImageRef thum = [asset thumbnail];
            //高清图片
            //        [[asset defaultRepresentation] fullResolutionImage];

            AVFile *file = [AVFile fileWithName:@"demo.png" data:UIImagePNGRepresentation([UIImage imageWithCGImage:[asset thumbnail]])];
            //保存图片
            AVObject *avobject = [AVObject objectWithClassName:@"ImagePicture"];
            [avobject setObject:file forKey:@"image"];
            [self.avFilePhotosArray addObject:avobject];
            
            [self.photosArray addObject:[UIImage imageWithCGImage:[asset thumbnail]]];
        }
        
        [self.detailInfoCollectionView reloadData];
        [self.view setNeedsUpdateConstraints];
        
        //    //数组形式保存
        [AVObject saveAllInBackground:self.avFilePhotosArray block:^(BOOL succeeded, NSError *error) {
            if (!error) {
                self.addressBookDetailInfo.fullResolutionImageRelation = [self.addressBookDetailInfo relationforKey:@"FullResolutionImageRelationShips"];

                for (AVObject *avobject in self.avFilePhotosArray) {
                    [self.addressBookDetailInfo.fullResolutionImageRelation addObject:avobject];
                }
                //update the postedMessage
                [self.addressBookDetailInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"成功");
                    }
                }];
            }
        }];
    }

    
    
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset
{
    // Enable video clips if they are at least 5s
    if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
    {
        NSTimeInterval duration = [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
        return lround(duration) >= 5;
    }
    else
    {
        return YES;
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    if (isChangeHeadIcon) {
        return (picker.selectedAssets.count < 2 && asset.defaultRepresentation != nil);
    }else{
        return asset.defaultRepresentation != nil ? YES : NO;
    }
//    if (picker.selectedAssets.count >= 10)
//    {
//        UIAlertView *alertView =
//        [[UIAlertView alloc] initWithTitle:@"Attention"
//                                   message:@"Please select not more than 10 assets"
//                                  delegate:nil
//                         cancelButtonTitle:nil
//                         otherButtonTitles:@"OK", nil];
//        
//        [alertView show];
//    }
//    
//    if (!asset.defaultRepresentation)
//    {
//        UIAlertView *alertView =
//        [[UIAlertView alloc] initWithTitle:@"Attention"
//                                   message:@"Your asset has not yet been downloaded to your device"
//                                  delegate:nil
//                         cancelButtonTitle:nil
//                         otherButtonTitles:@"OK", nil];
//        
//        [alertView show];
//    }
//    
//    return (picker.selectedAssets.count < 10 && asset.defaultRepresentation != nil);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self.view setNeedsUpdateConstraints];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddressBookDetailInfoControllerCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row == self.photosArray.count) {
        cell.detailiInfoImageView.image = [UIImage imageNamed:@"btn_add"];
    }else{
        cell.detailiInfoFile = self.avFilePhotosArray[indexPath.row];
        cell.detailiInfoImageView.image = self.photosArray[indexPath.row];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

}


- (CGRect)autoLayoutWithTextView:(UITextView *)textView
{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), fmaxf(120, newSize.height));
    textView.frame = newFrame;

    return newFrame;
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

//
//  ContactPlistTableViewCell.m
//  AccountManagement
//
//  Created by WeiHu on 15/6/10.
//  Copyright (c) 2015年 WeiHu. All rights reserved.
//

#import "ContactPlistTableViewCell.h"
#import "AddressBookDetailInfo.h"

@implementation ContactPlistTableViewCell

- (void)setAddressBookDetailInfo:(AddressBookDetailInfo *)addressBookDetailInfo
{
    _addressBookDetailInfo = addressBookDetailInfo;
    self.personNameLabel.text = addressBookDetailInfo.contactName;
    
    [addressBookDetailInfo.contactHeadIcon getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.personIconImageView.image = [UIImage imageWithData:data];
    }];
    
}
- (IBAction)phoneBtnAction:(id)sender {
    if (self.phoneBlock) {
        self.phoneBlock(self);
    }
}

@end

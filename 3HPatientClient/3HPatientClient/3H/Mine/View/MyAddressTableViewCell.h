//
//  MyAddressTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AddressListModel.h"
@interface MyAddressTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UIImageView *imgLogo;

//赋值
- (CGFloat)confingWithModel:(AddressListModel *)model;
@end

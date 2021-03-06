//
//  hopDetailBuyHeadTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AddressListModel.h"

@interface ShopDetailBuyHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgArrow;
- (void)configWithModel:(AddressListModel *)model;
@end

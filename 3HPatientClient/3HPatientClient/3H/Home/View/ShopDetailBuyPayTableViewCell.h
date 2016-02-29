//
//  hopDetailBuyPayTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ShopInfoModel.h"

@interface ShopDetailBuyPayTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labLine1;

@property (nonatomic, strong) UIImageView *imgZFB;

@property (nonatomic, strong) UILabel *labZFB;

@property (nonatomic, strong) UIButton *btnZFB;

@property (nonatomic, strong) UILabel *labLine2;

@property (nonatomic, strong) UIImageView *imgWX;

@property (nonatomic, strong) UILabel *labWX;

@property (nonatomic, strong) UIButton *btnWX;
//0 支付宝 1  微信
@property (nonatomic,copy) void(^payBlock)(NSInteger index);

- (void)configWithModel:(id)model;
@end

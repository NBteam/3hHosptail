//
//  hopDetailBuyDescTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ShopInfoModel.h"


@interface ShopDetailBuyDescTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labCode;

@property (nonatomic, strong) UILabel *labPrice;
@property (nonatomic, strong) UILabel *labNumName;

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UILabel *labNum;

@property (nonatomic, strong) UIButton *btnReduct;

@property (nonatomic, strong) UIButton *btnAdd;

//赋值
- (void)confingWithModel:(id)model;


@end

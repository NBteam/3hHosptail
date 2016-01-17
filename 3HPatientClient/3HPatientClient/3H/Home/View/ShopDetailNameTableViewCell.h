//
//  ShopDetailNameTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GoodsDetailModel.h"

@interface ShopDetailNameTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UILabel *labPrice;

@property (nonatomic,copy) void(^shopDetailBlock)(NSInteger index);

//赋值
- (CGFloat)confingWithGoodsDetailModel:(GoodsDetailModel *)model;
@end

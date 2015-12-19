//
//  ShopCustomView.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@interface ShopCustomView : UIView

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labNowPrice;

@property (nonatomic, strong) UILabel *labOldPriceName;

@property (nonatomic, strong) UILabel *labOldPrice;

@property (nonatomic, strong) UILabel *labLine;

//赋值
- (void)confingWithModel:(GoodsListModel *)model;
@end

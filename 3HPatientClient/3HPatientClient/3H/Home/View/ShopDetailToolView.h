//
//  ShopDetailToolView.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopDetailToolView : UIView

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UIButton *btnCollection;

@property (nonatomic, strong) UILabel *labCollection;

@property (nonatomic, strong) UIButton *btnAddCart;

@property (nonatomic, strong) UIButton *btnBuy;

@property (nonatomic, strong) UIButton *btnCart;

@property (nonatomic, strong) UILabel *labCart;
//0 收藏 1 加入购物车 2  立即购买  购物车 3
@property (nonatomic,copy) void(^ShopDetailToolBlock)(NSInteger index);
@end

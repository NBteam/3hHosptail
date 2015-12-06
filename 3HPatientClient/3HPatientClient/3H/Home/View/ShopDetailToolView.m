//
//  ShopDetailToolView.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailToolView.h"

@implementation ShopDetailToolView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

- (void)customView{
    [self addSubview:self.labLine];
    [self addSubview:self.btnCollection];
    [self addSubview:self.labCollection];
    [self addSubview:self.btnCart];
    [self addSubview:self.labCart];
    [self addSubview:self.btnAddCart];
    [self addSubview:self.btnBuy];
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];

    }
    return _labLine;
}
- (UIButton *)btnCollection{
    if (!_btnCollection) {
        _btnCollection = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCollection.frame = CGRectMake(10, 10, 21, 20);
        [_btnCollection setImage:[UIImage imageNamed:@"首页-健康商城-商品详情_收藏"] forState:UIControlStateNormal];
        [_btnCollection addTarget:self action:@selector(btnCollectionAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCollection;
}

- (void)btnCollectionAction{
    if (self.ShopDetailToolBlock) {
        self.ShopDetailToolBlock(0);
    }
}

- (UILabel *)labCollection{
    if (!_labCollection) {
        _labCollection = [[UILabel alloc] initWithFrame:CGRectMake(0, 65 -12 -10,  21 +20, 12)];
        _labCollection.textColor = [UIColor colorWithHEX:0x333333];
        _labCollection.font = [UIFont systemFontOfSize:12];
        _labCollection.textAlignment = NSTextAlignmentCenter;
        _labCollection.text = @"收藏";
    }
    return _labCollection;
}


- (UIButton *)btnCart{
    if (!_btnCart) {
        _btnCart = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCart.frame = CGRectMake(DeviceSize.width -21 -10, 10, 21, 20);
        [_btnCart setImage:[UIImage imageNamed:@"首页-健康商城-商品详情_购物车"] forState:UIControlStateNormal];
        [_btnCart addTarget:self action:@selector(btnCartAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCart;
}

- (void)btnCartAction{
    if (self.ShopDetailToolBlock) {
        self.ShopDetailToolBlock(3);
    }
}

- (UILabel *)labCart{
    if (!_labCart) {
        _labCart = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width -21 -20, 65 -12 -10,  21 +20, 12)];
        _labCart.textColor = [UIColor colorWithHEX:0x333333];
        _labCart.font = [UIFont systemFontOfSize:12];
        _labCart.textAlignment = NSTextAlignmentCenter;
        _labCart.text = @"购物车";
    }
    return _labCart;
}

- (UIButton *)btnAddCart{
    if (!_btnAddCart) {
        _btnAddCart = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAddCart.backgroundColor = AppDefaultColor;
        _btnAddCart.frame = CGRectMake(self.labCollection.right, 10, (self.labCart.left -self.labCollection.right -10)/2, 45);
        _btnAddCart.layer.masksToBounds = YES;
        _btnAddCart.layer.cornerRadius = 5;
        [_btnAddCart setTitle:@"加入购物车" forState:UIControlStateNormal];
        _btnAddCart.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnAddCart setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnAddCart addTarget:self action:@selector(btnAddCartAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddCart;
}

- (void)btnAddCartAction{
    if (self.ShopDetailToolBlock) {
        self.ShopDetailToolBlock(1);
    }
}

- (UIButton *)btnBuy{
    if (!_btnBuy) {
        _btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBuy.backgroundColor = [UIColor redColor];
        _btnBuy.frame = CGRectMake(self.btnAddCart.right +10, 10, (self.labCart.left -self.labCollection.right -10)/2, 45);
        _btnBuy.layer.masksToBounds = YES;
        _btnBuy.layer.cornerRadius = 5;
        [_btnBuy setTitle:@"立即购买" forState:UIControlStateNormal];
        _btnBuy.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnBuy setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnBuy addTarget:self action:@selector(btnBuyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBuy;
}

- (void)btnBuyAction{
    if (self.ShopDetailToolBlock) {
        self.ShopDetailToolBlock(2);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

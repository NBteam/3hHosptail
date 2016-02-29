//
//  hopDetailBuyPayTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailBuyPayTableViewCell.h"
#import "CartListModel.h"
@implementation ShopDetailBuyPayTableViewCell


- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLine1];
    [self.contentView addSubview:self.imgZFB];
    [self.contentView addSubview:self.labZFB];
    [self.contentView addSubview:self.btnZFB];
    
    [self.contentView addSubview:self.labLine2];
    [self.contentView addSubview:self.imgWX];
    [self.contentView addSubview:self.labWX];
    [self.contentView addSubview:self.btnWX];
    
    if (self.BuyPayBlock) {
        self.BuyPayBlock(0);
    }
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 15)];
        _labTitle.textColor = AppDefaultColor;
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.text = @"总价:0元";
    }
    return _labTitle;
}

- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, self.labTitle.width, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];

    }
    return _labLine1;
}

- (UIImageView *)imgZFB{
    if (!_imgZFB) {
        _imgZFB = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.labLine1.bottom +16, 13, 13)];
        _imgZFB.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_支付-点击状态"];
    }
    return _imgZFB;
}

- (UILabel *)labZFB{
    if (!_labZFB) {
        _labZFB = [[UILabel alloc] initWithFrame:CGRectMake(self.imgZFB.right +10, self.labLine1.bottom +15, DeviceSize.width/2, 15)];
        _labZFB.textColor = [UIColor colorWithHEX:0x333333];
        _labZFB.font = [UIFont systemFontOfSize:15];
        _labZFB.text = @"支付宝支付";
    }
    return _labZFB;
}

- (UIButton *)btnZFB{
    if (!_btnZFB) {
        _btnZFB = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnZFB.frame = CGRectMake(0, self.labLine1.bottom, DeviceSize.width, 45);
        _btnZFB.backgroundColor = [UIColor clearColor];
        [_btnZFB addTarget:self action:@selector(btnZFBAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnZFB;
}

- (void)btnZFBAction{
    self.imgZFB.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_支付-点击状态"];
    self.imgWX.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_点击-非点击状态"];
    if (self.BuyPayBlock) {
        
        self.BuyPayBlock(0);
    }
}

- (UILabel *)labLine2{
    if (!_labLine2) {
        _labLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.btnZFB.bottom, self.labTitle.width, 0.5)];
        _labLine2.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine2;
}

- (UIImageView *)imgWX{
    if (!_imgWX) {
        _imgWX = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.labLine2.bottom +16, 13, 13)];
        _imgWX.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_点击-非点击状态"];
    }
    return _imgWX;
}

- (UILabel *)labWX{
    if (!_labWX) {
        _labWX = [[UILabel alloc] initWithFrame:CGRectMake(self.imgWX.right +10, self.labLine2.bottom +15, DeviceSize.width/2, 15)];
        _labWX.textColor = [UIColor colorWithHEX:0x333333];
        _labWX.font = [UIFont systemFontOfSize:15];
        _labWX.text = @"微信支付";
    }
    return _labWX;
}

- (UIButton *)btnWX{
    if (!_btnWX) {
        _btnWX = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWX.frame = CGRectMake(0, self.labLine2.bottom, DeviceSize.width, 45);
        _btnWX.backgroundColor = [UIColor clearColor];
        [_btnWX addTarget:self action:@selector(btnWXAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnWX;
}

- (void)btnWXAction{
    self.imgWX.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_支付-点击状态"];
    self.imgZFB.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买_点击-非点击状态"];
    if (self.BuyPayBlock) {
        self.BuyPayBlock(1);
    }
}
- (void)configWithModel:(id)model{
    if ([model isKindOfClass:[ShopInfoModel class]]) {
        ShopInfoModel * item = (ShopInfoModel *)model;
        self.labTitle.text = [NSString stringWithFormat:@"总价:%.2f元",[item.price doubleValue]*[item.indexStr doubleValue]];
    }else{
        double price = 0;
        for (CartListModel * item in model) {
            price += [item.price doubleValue]*[item.qty doubleValue];
        }
        self.labTitle.text = [NSString stringWithFormat:@"总价:%.2f元",price];
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

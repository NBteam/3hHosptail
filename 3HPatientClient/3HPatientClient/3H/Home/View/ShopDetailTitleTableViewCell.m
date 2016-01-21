//
//  ShopDetailTitleTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailTitleTableViewCell.h"

@implementation ShopDetailTitleTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
//    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labTitle];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 25/2)];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 10, self.imgArrow.right -self.imgLogo.right -10, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width -17/2 -10, (35 -15)/2, 17/2, 15)];
        _imgArrow.image = [UIImage imageNamed:@""];
    }
    return _imgArrow;
}

//赋值
- (void)confingWithModel:(NSString *)model{
    if ([model isEqualToString:@"商品详情"]) {
        self.imgLogo.image = [UIImage imageNamed:@"首页-健康商城-商品详情_商品介绍"];
    }else{
        self.imgLogo.image = [UIImage imageNamed:@"首页-健康商城-商品详情_评论"];
    }
    self.labTitle.text = model;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

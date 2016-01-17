//
//  ShopDetailNameTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailNameTableViewCell.h"

@implementation ShopDetailNameTableViewCell


- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
    [self.contentView addSubview:self.labPrice];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, DeviceSize.width -20, 0)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:12];
        _labDetail.numberOfLines = 0;
    }
    return _labDetail;
}

- (UILabel *)labPrice{
    if (!_labPrice) {
        _labPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 13)];
        _labPrice.textColor = AppDefaultColor;
        _labPrice.font = [UIFont systemFontOfSize:15];
    }
    return _labPrice;
}
//赋值
- (CGFloat)confingWithGoodsDetailModel:(GoodsDetailModel *)model{
    self.labTitle.text = model.name;
    self.labDetail.text = model.rec_title;
    [self.labDetail sizeToFit];
    self.labPrice.top = self.labDetail.bottom +10;
    self.labPrice.text = [NSString stringWithFormat:@"3H价:%@元",model.price];
    return self.labPrice.bottom +10;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  ShopCustomView.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopCustomView.h"

@implementation ShopCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        self.layer.borderWidth = 0.5;
        [self customView];
    }
    return self;
}

- (void)customView{
    [self addSubview:self.imgLogo];
    [self addSubview:self.labTitle];
    [self addSubview:self.labNowPrice];
//    [self addSubview:self.labOldPriceName];
//    [self addSubview:self.labOldPrice];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width/2  -15, 125)];
        _imgLogo.image = [UIImage imageNamed:@""];
        _imgLogo.layer.borderWidth = 0.5;
        _imgLogo.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _imgLogo.backgroundColor = [UIColor whiteColor];
//        _imgLogo.contentMode = UIViewContentModeScaleAspectFill;
//        _imgLogo.clipsToBounds = true;
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, self.imgLogo.bottom +10, self.imgLogo.width -10, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labNowPrice{
    if (!_labNowPrice) {
        _labNowPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.labTitle.left, self.labTitle.bottom +5 +18, self.imgLogo.width -10, 13)];
        _labNowPrice.textColor = AppDefaultColor;
        _labNowPrice.font = [UIFont systemFontOfSize:13];
    }
    return _labNowPrice;
}

- (UILabel *)labOldPriceName{
    if (!_labOldPriceName) {
        _labOldPriceName = [[UILabel alloc] initWithFrame:CGRectMake(self.labNowPrice.left, self.labNowPrice.bottom +5, self.imgLogo.width -10, 12)];
        _labOldPriceName.textColor = [UIColor colorWithHEX:0x999999];
        _labOldPriceName.font = [UIFont systemFontOfSize:12];
        _labOldPriceName.text = @"原价:";
        CGSize size = [_labOldPriceName.text sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(0, 12)];
        _labOldPriceName.width = size.width;
        
    }
    return _labOldPriceName;
}

- (UILabel *)labOldPrice{
    if (!_labOldPrice) {
        _labOldPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.labOldPriceName.right, self.labNowPrice.bottom +5, self.imgLogo.width -10 -self.labOldPriceName.right, 12)];
        _labOldPrice.textColor = [UIColor colorWithHEX:0x999999];
        _labOldPrice.font = [UIFont systemFontOfSize:12];
    }
    return _labOldPrice;
}
//NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};

//赋值
- (void)confingWithModel:(GoodsListModel *)model{
    self.labTitle.text = model.name;
    self.labNowPrice.text = [NSString stringWithFormat:@"会员价:￥%@元",model.price];
    //NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    [self.imgLogo sd_setImageWithURL:SD_IMG(model.thumb)];
//    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",model.market_price] attributes:attribtDic];
//    self.labOldPrice.attributedText = attribtStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

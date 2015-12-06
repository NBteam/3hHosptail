//
//  WalletHeadTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "WalletHeadTableViewCell.h"

@implementation WalletHeadTableViewCell


- (void)customView{
    self.contentView.backgroundColor = [UIColor colorWithHEX:0xff813c];
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 17, 17)];
        _imgLogo.image = [UIImage imageNamed:@"我的-我的钱包_账户余额"];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +5, 30, DeviceSize.width -self.imgLogo.right -5 -10, 17)];
        _labTitle.textColor = [UIColor colorWithHEX:0xffffff];
        _labTitle.font = [UIFont systemFontOfSize:16];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.left, self.imgLogo.bottom +15, DeviceSize.width - 40, 50)];
        _labDetail.textColor = [UIColor colorWithHEX:0xffffff];
        _labDetail.font = [UIFont boldSystemFontOfSize:50];
    }
    return _labDetail;
}

//赋值
- (void)confingWithModel:(NSDictionary *)dic{
    self.labTitle.text = @"账户余额";
    self.labDetail.text = @"5000.00";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

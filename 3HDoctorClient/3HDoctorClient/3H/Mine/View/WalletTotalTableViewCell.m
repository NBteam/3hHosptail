//
//  WalletTotalTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "WalletTotalTableViewCell.h"

@implementation WalletTotalTableViewCell
- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 17, 17)];
        _imgLogo.image = [UIImage imageNamed:@"我的-个人中心-我的钱包_总金额"];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +5, 10, DeviceSize.width -self.imgLogo.right -5 -10, 17)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:12];
        _labTitle.text = @"总金额(元)";
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.labTitle.left, self.imgLogo.bottom +10, DeviceSize.width - self.labTitle.left*2, 20)];
        _labDetail.textColor = [UIColor colorWithHEX:0xff813c];
        _labDetail.font = [UIFont systemFontOfSize:25];
    }
    return _labDetail;
}

//赋值
- (void)confingWithModel:(NSDictionary *)dic{
    self.labDetail.text = [NSString stringWithFormat:@"%.2f",[dic[@"account"] floatValue]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

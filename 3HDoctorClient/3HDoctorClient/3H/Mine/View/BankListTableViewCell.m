//
//  BankListTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/9.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BankListTableViewCell.h"

@implementation BankListTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labName];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
        _imgLogo.layer.masksToBounds = YES;
        _imgLogo.layer.cornerRadius = 35/2;
        _imgLogo.backgroundColor = AppDefaultColor;
    }
    
    return _imgLogo;
}

- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 0, self.imgArrow.left - self.imgLogo.right - 20, 55)];
        _labName.textColor = [UIColor colorWithHEX:0x333333];
        _labName.font = [UIFont systemFontOfSize:15];
    }
    return _labName;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (55 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"3H-首页_键"];
        
    }
    return _imgArrow;
}
//赋值
//赋值
- (void)confingWithModel:(BankListModel *)model{
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.labName.text = model.name;
}

@end

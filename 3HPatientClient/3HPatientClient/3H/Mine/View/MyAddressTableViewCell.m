//
//  MyAddressTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyAddressTableViewCell.h"

@implementation MyAddressTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 25, (75 -15)/2, 15, 15)];
        _imgLogo.backgroundColor = [UIColor grayColor];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.imgLogo.left - 20, 15)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.numberOfLines = 0;
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, 75 -15 -10, self.imgLogo.left - 20, 15)];
        _labDetail.font = [UIFont systemFontOfSize:15];
        _labDetail.textColor = [UIColor colorWithHEX:0x333333];
    }
    return _labDetail;
}

//赋值
- (CGFloat)confingWithModel:(AddressListModel *)model{
    self.labTitle.text = model.address;
    [self.labTitle sizeToFit];
    self.labTitle.width = DeviceSize.width - 40;
    self.labDetail.top = self.labTitle.bottom + 10;
    self.imgLogo.top = (self.labDetail.bottom + 10 - 15)/2;
    self.labDetail.text = [NSString stringWithFormat:@"%@  %@",model.name,model.mobile];
    return self.labDetail.bottom + 10;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

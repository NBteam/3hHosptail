//
//  AppointDoctorsTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointDoctorsTableViewCell.h"

@implementation AppointDoctorsTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLine];
    [self.contentView addSubview:self.labDetail];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 14)];
        
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 10, 100, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, DeviceSize.width -20, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labLine.bottom +10, DeviceSize.width -20, 0)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.numberOfLines = 0;
    }
    return _labDetail;
}

//赋值
- (CGFloat)confingWithModel:(NSInteger )dic{
    if (dic == 0) {
        self.imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约挂号_简介"];
        self.labTitle.text = @"简介";
    }else{
        self.imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约挂号_擅长"];
        self.labTitle.text = @"擅长";
    }
    self.labDetail.text = @"赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值赋值";
    [self.labDetail sizeToFit];
    return self.labDetail.bottom +10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

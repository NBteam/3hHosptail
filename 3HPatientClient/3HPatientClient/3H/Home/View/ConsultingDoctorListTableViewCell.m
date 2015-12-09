//
//  ConsultingDoctorListTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingDoctorListTableViewCell.h"

@implementation ConsultingDoctorListTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        _imgLogo.backgroundColor = AppDefaultColor;
        _imgLogo.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _imgLogo.layer.borderWidth = 0.5;
        _imgLogo.layer.masksToBounds = YES;
        _imgLogo.layer.cornerRadius = 30;
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.imgLogo.top +10, self.imgArrow.right -20 -self.imgLogo.right, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.labTitle.left, self.imgLogo.bottom -23, self.imgArrow.right -20 -self.imgLogo.right, 13)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:13];
    }
    return _labDetail;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width -17/2 -10, (80 -15)/2, 17/2, 15)];
        _imgArrow.image = [UIImage imageNamed:@"arrowImg"];
    }
    return _imgArrow;
}

//赋值
- (void)confingWithModel:(NSInteger )dic{
    self.labTitle.text = @"范英强";
    self.labDetail.text = @"范英强范英强范英强范英强范英强范英强范英强范英强范英强";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

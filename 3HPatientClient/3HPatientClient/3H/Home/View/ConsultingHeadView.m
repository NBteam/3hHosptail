//
//  ConsultingHeadView.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingHeadView.h"

@implementation ConsultingHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgLogo];
        [self addSubview:self.imgDoctorPic];
        [self addSubview:self.labDoctorName];
        [self addSubview:self.labDoctorInfo];
    }
    return self;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 278/2)];
        _imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约挂号_背景"];
    }
    return _imgLogo;
}
- (UIImageView *)imgDoctorPic{
    if (!_imgDoctorPic) {
        _imgDoctorPic = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width -65)/2, 15, 65, 65)];
        _imgDoctorPic.backgroundColor = [UIColor grayColor];
        _imgDoctorPic.layer.masksToBounds = YES;
        _imgDoctorPic.layer.cornerRadius = 65/2;
        _imgDoctorPic.clipsToBounds = NO;
    }
    return _imgDoctorPic;
}

- (UILabel *)labDoctorName{
    if (!_labDoctorName) {
        _labDoctorName = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgDoctorPic.bottom +10, DeviceSize.width, 15)];
        _labDoctorName.textColor = [UIColor colorWithHEX:0xffffff];
        _labDoctorName.textAlignment = NSTextAlignmentCenter;
    }
    return _labDoctorName;
}

- (UILabel *)labDoctorInfo{
    if (!_labDoctorInfo) {
        _labDoctorInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, self.labDoctorName.bottom +10, DeviceSize.width, 13)];
        _labDoctorInfo.textColor = [UIColor colorWithHEX:0xffffff];
        _labDoctorInfo.font = [UIFont systemFontOfSize:13];
        _labDoctorInfo.textAlignment = NSTextAlignmentCenter;
    }
    return _labDoctorInfo;
}
//赋值

- (void)confingWithModel:(DoctorInfoModel *)model{
    
    self.labDoctorName.text = model.truename;
    self.labDoctorInfo.text = [NSString stringWithFormat:@"%@ %@",model.hospital,model.job_title];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

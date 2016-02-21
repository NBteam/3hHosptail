//
//  MineHeadTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MineHeadTableViewCell.h"

@implementation MineHeadTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgDoctorPic];
    [self.contentView addSubview:self.labDoctorName];
    [self.contentView addSubview:self.labDoctorInfo];
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.btnAttestation];
}

- (UIImageView *)imgDoctorPic{
    if (!_imgDoctorPic) {
        _imgDoctorPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 50, 50)];
        _imgDoctorPic.backgroundColor = [UIColor grayColor];
        _imgDoctorPic.layer.masksToBounds = YES;
        _imgDoctorPic.layer.cornerRadius = 25.0f;
    }
    return _imgDoctorPic;
    
}

- (UILabel *)labDoctorName{
    if (!_labDoctorName) {
        _labDoctorName = [[UILabel alloc] initWithFrame:CGRectMake(self.imgDoctorPic.right +7, self.imgDoctorPic.top +6, 100, 15)];
        _labDoctorName.textColor = [UIColor colorWithHEX:0x333333];
        _labDoctorName.font = [UIFont systemFontOfSize:15];
    }
    return _labDoctorName;
}

- (UILabel *)labDoctorInfo{
    if (!_labDoctorInfo) {
        _labDoctorInfo = [[UILabel alloc] initWithFrame:CGRectMake(self.imgDoctorPic.right +7, self.labDoctorName.bottom +7, DeviceSize.width/2, 13)];
        _labDoctorInfo.textColor = [UIColor colorWithHEX:0x999999];
        _labDoctorInfo.font = [UIFont systemFontOfSize:13];
    }
    return _labDoctorInfo;
}

- (UIButton *)btnAttestation{
    if (!_btnAttestation) {
        _btnAttestation = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAttestation.frame = CGRectMake(self.imgArrow.left -10 -60, (80 -25)/2, 60, 25);
        _btnAttestation.backgroundColor = [UIColor colorWithHEX:0xff813c];
        _btnAttestation.titleLabel.font = [UIFont systemFontOfSize:12];
        _btnAttestation.layer.masksToBounds = YES;
        _btnAttestation.layer.cornerRadius = 3;
        [_btnAttestation setTitle:@"已认证" forState:UIControlStateNormal];
        [_btnAttestation setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnAttestation addTarget:self action:@selector(btnAttestationAction) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _btnAttestation;
}

- (void)btnAttestationAction{
    
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (80 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"3H-首页_键"];
        
    }
    return _imgArrow;
}
//is_checked			认证状态，0未认证，1请求认证，2认证通过，3认证不通过
- (void)confingWithModelOfName:(NSString *)name Hosptail:(NSString *)hosptail Job:(NSString *)job Pic:(NSString *)pic Checked:(NSString *)checked{
    NSLog(@"----%@",pic);
    self.labDoctorName.text = name;
    self.labDoctorInfo.text = [NSString stringWithFormat:@"%@  %@",hosptail,job];
    [self.imgDoctorPic sd_setImageWithURL:URL(pic) placeholderImage:IMG(@"")];
    
    if ([checked isEqualToString:@"1"]) {
        [self.btnAttestation setTitle:@"已认证" forState:UIControlStateNormal];
    }else{
        [self.btnAttestation setTitle:@"未认证" forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  PatientDetailHeadTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "PatientDetailHeadTableViewCell.h"

@implementation PatientDetailHeadTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgPatientPic];
    [self.contentView addSubview:self.labPatientName];
    [self.contentView addSubview:self.labPatientInfo];

}

- (UIImageView *)imgPatientPic{
    if (!_imgPatientPic) {
        _imgPatientPic = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 80)];
        _imgPatientPic.backgroundColor = [UIColor grayColor];
        _imgPatientPic.layer.masksToBounds = YES;
        _imgPatientPic.layer.cornerRadius = 40.0f;
    }
    return _imgPatientPic;
    
}

- (UILabel *)labPatientName{
    if (!_labPatientName) {
        _labPatientName = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatientPic.right +10, self.imgPatientPic.top +15, 100, 15)];
        _labPatientName.textColor = [UIColor colorWithHEX:0x333333];
        _labPatientName.font = [UIFont systemFontOfSize:15];
    }
    return _labPatientName;
}

- (UILabel *)labPatientInfo{
    if (!_labPatientInfo) {
        _labPatientInfo = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatientPic.right +10, self.imgPatientPic.bottom -14 -15, DeviceSize.width/2, 14)];
        _labPatientInfo.textColor = [UIColor colorWithHEX:0x999999];
        _labPatientInfo.font = [UIFont systemFontOfSize:14];
    }
    return _labPatientInfo;
}


- (void)confingWithModel:(PatientListModel *)model{
    self.labPatientName.text = model.truename;
    self.labPatientInfo.text = [NSString stringWithFormat:@"%@  %@",model.age,model.sex];
    [self.imgPatientPic sd_setImageWithURL:URL(model.pic) placeholderImage:IMG(@"")];
    
    ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

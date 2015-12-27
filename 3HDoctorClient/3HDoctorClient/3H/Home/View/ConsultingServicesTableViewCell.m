//
//  ConsultingServicesTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingServicesTableViewCell.h"

@implementation ConsultingServicesTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgPatient];
    [self.contentView addSubview:self.labPatientName];
    [self.contentView addSubview:self.labPatientDetail];
    [self.contentView addSubview:self.labTime];
    [self.contentView addSubview:self.labLine];
    [self.contentView addSubview:self.labDescribe];
}

- (UIImageView *)imgPatient{
    if (!_imgPatient) {
        _imgPatient = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _imgPatient.backgroundColor = [UIColor grayColor];
        _imgPatient.layer.masksToBounds = YES;
        _imgPatient.layer.cornerRadius = 25;
        
    }
    return _imgPatient;
}

- (UILabel *)labPatientName{
    if (!_labPatientName) {
        _labPatientName = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatient.right +10, self.imgPatient.top +5, 100, 15)];
        _labPatientName.textColor = [UIColor colorWithHEX:0x333333];
        _labPatientName.font = [UIFont systemFontOfSize:15];
    }
    return _labPatientName;
}

- (UILabel *)labPatientDetail{
    if (!_labPatientDetail) {
        _labPatientDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatient.right +10, self.imgPatient.bottom -5 -13, 100, 13)];
        _labPatientDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labPatientDetail.font = [UIFont systemFontOfSize:13];
    }
    return _labPatientDetail;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width -10 -100, self.labPatientName.top +5, 100, 13)];
        _labTime.textColor = [UIColor colorWithHEX:0x999999];
        _labTime.font = [UIFont systemFontOfSize:13];
        _labTime.textAlignment = NSTextAlignmentRight;
    }
    return _labTime;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imgPatient.bottom +10, DeviceSize.width -20, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (UILabel *)labDescribe{
    if (!_labDescribe) {
        _labDescribe = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labLine.bottom +10, DeviceSize.width -20, 13)];
        _labDescribe.textColor = [UIColor colorWithHEX:0x666666];
        _labDescribe.font = [UIFont systemFontOfSize:13];
    }
    return _labDescribe;
}

//赋值
- (void )confingWithModel:(ConsultingUnFinishedModel *)dic{
    self.labPatientName.text = dic.truename;
    self.labPatientDetail.text = [NSString stringWithFormat:@"%@ %@",dic.age,dic.sex];
    self.labTime.text = dic.addtime;
    self.labDescribe.text = dic.chat_desc;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

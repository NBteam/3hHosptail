//
//  ConsultingDoctorListNewCell.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ConsultingDoctorListNewCell.h"

@implementation ConsultingDoctorListNewCell
- (void)customView{
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.viewOrange];
    [self.viewOrange addSubview:self.imgHead];
    [self.viewOrange addSubview:self.labName];
    [self.viewOrange addSubview:self.labHospital];
    [self.viewBack addSubview:self.labDetail];
}
- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(10, 10, DeviceSize.width-20, 180)];
        _viewBack.backgroundColor = [UIColor whiteColor];
        _viewBack.layer.cornerRadius = 6.f;
        _viewBack.layer.masksToBounds = YES;
        _viewBack.layer.borderWidth = 0.5;
        _viewBack.layer.borderColor = [UIColor orangeColor].CGColor;//边框颜色,要为CGColor
    }
    return _viewBack;
}
- (UIView *)viewOrange{
    if (!_viewOrange) {
        _viewOrange = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.viewBack.width, 130)];
        _viewOrange.backgroundColor = [UIColor colorWithHEX:0xff9358];
    }
    return _viewOrange;
}
- (UIImageView *)imgHead{
    if (!_imgHead) {
        _imgHead = [[UIImageView alloc] initWithFrame:CGRectMake((self.viewBack.width -65)/2, 15, 65, 65)];
        _imgHead.backgroundColor = [UIColor grayColor];
        _imgHead.layer.masksToBounds = YES;
        _imgHead.layer.cornerRadius = 65/2;
        _imgHead.clipsToBounds = YES;
        _imgHead.layer.borderWidth = 1;
        _imgHead.layer.borderColor = [UIColor orangeColor].CGColor;//边框颜色,要为CGColor
    }
    return _imgHead;
}

- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgHead.bottom +10, self.viewOrange.width, 15)];
        _labName.textColor = [UIColor colorWithHEX:0xffffff];
        _labName.textAlignment = NSTextAlignmentCenter;
    }
    return _labName;
}

- (UILabel *)labHospital{
    if (!_labHospital) {
        _labHospital = [[UILabel alloc] initWithFrame:CGRectMake(0, self.labName.bottom +10, self.viewOrange.width, 13)];
        _labHospital.textColor = [UIColor colorWithHEX:0xffffff];
        _labHospital.font = [UIFont systemFontOfSize:13];
        _labHospital.textAlignment = NSTextAlignmentCenter;
    }
    return _labHospital;
}
- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc]initWithFrame:CGRectMake(15, self.viewOrange.bottom + 5, self.viewBack.width-30, 40)];
        _labDetail.textColor = [UIColor orangeColor];
        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.numberOfLines = 2;
        _labDetail.textAlignment = NSTextAlignmentCenter;
    }
    return _labDetail;
}
- (CGFloat)confingWithModel:(DoctorListModel *)model{
    
    [self.imgHead sd_setImageWithURL:SD_IMG(model.pic)];
    self.labDetail.text = @"问我师傅说的话就考试复试讲课方式缴费卡睡了好久发开房间爱看了罚款了发发火看见了罚款发放哈利法立法撒发生发发发发生发放";
    self.labHospital.text = [NSString stringWithFormat:@"(%@ %@)",model.hospital,model.job_title];
    self.labName.text = model.truename;
    self.viewOrange.height = self.labHospital.bottom + 10;
    self.labDetail.top = self.viewOrange.bottom + 5;
    self.viewBack.height = self.labDetail.bottom + 5;
    return self.viewBack.bottom;
}
- (CGFloat)confingWithAppointExpertListModel:(AppointExpertListModel *)model{
    [self.imgHead sd_setImageWithURL:SD_IMG(model.pic)];
    self.labDetail.text = model.desc;
    self.labHospital.text = [NSString stringWithFormat:@"(%@ %@)",model.hospital,model.job_title];
    self.labName.text = model.truename;
    self.viewOrange.height = self.labHospital.bottom + 10;
    self.labDetail.top = self.viewOrange.bottom + 5;
    self.viewBack.height = self.labDetail.bottom + 5;
    return self.viewBack.bottom;
}
@end

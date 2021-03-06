//
//  MyAppointmentTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyAppointmentTableViewCell.h"

@implementation MyAppointmentTableViewCell


- (void)customView{
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.imgBack];
    [self.viewBack addSubview:self.imgDoctorPic];
    [self.viewBack addSubview:self.labState];
    [self.viewBack addSubview:self.labTitle];
    [self.viewBack addSubview:self.labDetail];
    [self.viewBack addSubview:self.labTime];
    [self.viewBack addSubview:self.labLine];
    [self.viewBack addSubview:self.imgLogo];
    [self.viewBack addSubview:self.labPrice];
    [self.viewBack addSubview:self.labAppraise];
//    [self.viewBack addSubview:self.imgAppraise];
    
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width - 20, 145)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
        _viewBack.layer.masksToBounds = YES;
        _viewBack.layer.cornerRadius = 5;
    }
    return _viewBack;
}

- (UIImageView *)imgBack{
    if (!_imgBack) {
        _imgBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.viewBack.width, 105)];
        _imgBack.image = [UIImage imageNamed:@"我的-我的预约_未评价背景"];
    }
    return _imgBack;
}

- (UIImageView *)imgDoctorPic{
    if (!_imgDoctorPic) {
        _imgDoctorPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 75, 75)];
        _imgDoctorPic.backgroundColor = [UIColor grayColor];
        _imgDoctorPic.layer.masksToBounds = YES;
        _imgDoctorPic.layer.cornerRadius = 75/2;
    }
    return _imgDoctorPic;
}

- (UILabel *)labState{
    if (!_labState) {
        _labState = [[UILabel alloc] initWithFrame:CGRectMake(self.viewBack.width -60, 0, 50, 105)];
        _labState.textColor = [UIColor colorWithHEX:0x888888];
        _labState.font = [UIFont systemFontOfSize:13];
        _labState.numberOfLines = 0;
        _labState.textAlignment = NSTextAlignmentCenter;
        
    }
    return _labState;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgDoctorPic.right +10, self.imgDoctorPic.top +5, self.labState.right - 10 - self.imgDoctorPic.right - 10, 15)];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgDoctorPic.right +10, self.labTitle.bottom +10, self.labState.right - 10 - self.imgDoctorPic.right - 10, 13)];
        _labDetail.font = [UIFont systemFontOfSize:13];
    }
    return _labDetail;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(self.imgDoctorPic.right +10, self.labDetail.bottom +10, self.labState.right - 10 - self.imgDoctorPic.right - 10, 13)];
        _labTime.font = [UIFont systemFontOfSize:13];
    }
    return _labTime;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 105, self.viewBack.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];

    }
    return _labLine;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.labLine.bottom -0.5 +(40 -17)/2, 17, 17)];
        _imgLogo.image = [UIImage imageNamed:@"我的-我的预约_实付"];
    }
    return _imgLogo;
}

- (UILabel *)labPrice{
    if (!_labPrice) {
        _labPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +5, self.labLine.bottom -0.5, DeviceSize.width/2, 40)];
        _labPrice.textColor = [UIColor colorWithHEX:0x333333];
        _labPrice.font = [UIFont systemFontOfSize:15];
    }
    return _labPrice;
}

- (UILabel *)labAppraise{
    if (!_labAppraise) {
        _labAppraise = [[UILabel alloc] initWithFrame:CGRectMake(self.viewBack.width -10 -160, self.labLine.bottom -0.5, 160, 40)];
        _labAppraise.textColor = [UIColor colorWithHEX:0x999999];
        _labAppraise.font = [UIFont systemFontOfSize:13];
        _labAppraise.textAlignment = NSTextAlignmentRight;
    }
    return _labAppraise;
}

//- (UIImageView *)imgAppraise{
//    if (!_imgAppraise) {
//        _imgAppraise = [[UIImageView alloc] initWithFrame:CGRectMake(self.labAppraise.left -5 -37/2, self.labLine.bottom -0.5 +(40 -17)/2, 37/2, 34/2)];
//        _imgAppraise.image = [UIImage imageNamed:@"我的-我的预约_未评价"];
//    }
//    return _imgAppraise;
//}
//	id						订单ID
//	order_sn					订单编号
//	total						订单金额
//	pay_status				支付状态，0未支付，1已经支付
//	status_n					订单状态描述
//	addtime					订单提交日期
//	order_date_n				预约时间段
//
//	truename				医生名称
//	job_title					医生职称
//	hospital					医生医院
//	department				医生科室
//	pic						医生头像
//赋值
- (void)confingWithModel:(MyAppointmentRegisteredModel *)model index:(NSInteger)index{
    self.labTitle.text = [NSString stringWithFormat:@"%@ %@",model.truename,model.job_title];
    self.labDetail.text = [NSString stringWithFormat:@"%@ %@",model.hospital,model.department];
    self.labTime.text = model.order_date_n;
    [self.imgDoctorPic sd_setImageWithURL:SD_IMG(model.pic)];
    if (model.total) {
        self.labPrice.text = [NSString stringWithFormat:@"实付:%@元",model.total] ;
    }else{
        self.labPrice.text = [NSString stringWithFormat:@"实付:%@元",model.price] ;
    }
    if (index == 0) {
        self.labPrice.hidden = YES;
        self.imgLogo.hidden = YES;
    }else{
        self.labPrice.hidden = NO;
        self.imgLogo.hidden = NO;
    }
    self.labAppraise.text = model.order_date_n;
    if ([model.status_n isEqualToString:@"0"]) {
        self.labState.text = @"等待医生确认";
        self.labState.textColor = [UIColor whiteColor];
        self.imgBack.hidden = NO;
        self.labLine.hidden = YES;
        self.labTitle.textColor = [UIColor colorWithHEX:0xffffff];
        self.labDetail.textColor = [UIColor colorWithHEX:0xffffff];
        self.labTime.textColor = [UIColor colorWithHEX:0xffffff];
    }else{
        self.labState.text = @"已确认";
        self.labState.textColor = AppDefaultColor;
        self.imgBack.hidden = YES;
        self.labLine.hidden = NO;
        self.labTitle.textColor = [UIColor colorWithHEX:0x888888];
        self.labDetail.textColor = [UIColor colorWithHEX:0x888888];
        self.labTime.textColor = [UIColor colorWithHEX:0x888888];
    }
    self.labState.text = model.status_n;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

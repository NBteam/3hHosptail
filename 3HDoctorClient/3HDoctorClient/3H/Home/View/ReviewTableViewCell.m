//
//  ReviewTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ReviewTableViewCell.h"

@implementation ReviewTableViewCell


- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, 55 -10 -12, DeviceSize.width -20, 12)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:12];

    }
    return _labDetail;
}

//赋值
- (void)confingWithModel:(PatientRecheckModel *)model{
    self.labTitle.text = model.prj_name;
    self.labDetail.text = [NSString stringWithFormat:@"请于%@上午到%@进行门诊随诊",model.check_date,model.hospital] ;
}
//id				记录ID
//check_date		复查日期
//check_time		复查时段
//hospital			医院
//prj_name		复查项目

@end

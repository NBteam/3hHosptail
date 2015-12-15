//
//  PatientDetailHeadTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PatientListModel.h"

@interface PatientDetailHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgPatientPic;

@property (nonatomic, strong) UILabel *labPatientName;

@property (nonatomic, strong) UILabel *labPatientInfo;

//赋值
- (void)confingWithModel:(PatientListModel *)model;

@end

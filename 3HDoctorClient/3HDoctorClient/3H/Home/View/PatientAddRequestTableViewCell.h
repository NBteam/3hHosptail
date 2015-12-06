//
//  PatientAddRequestTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PatientAddRequestModel.h"

@interface PatientAddRequestTableViewCell : BaseTableViewCell

//患者头像
@property (nonatomic, strong) UIImageView *imgPatient;
//患者title
@property (nonatomic, strong) UILabel *labTitle;
//患者状况
@property (nonatomic, strong) UILabel *labDetail;
//拒绝
@property (nonatomic, strong) UIButton *btnRefused;
//同意
@property (nonatomic, strong) UIButton *btnAgreed;
//赋值
- (void)confingWithModel:(PatientAddRequestModel *)dic;
@property (nonatomic, copy) void(^btnAgreedBlock)(void);
@property (nonatomic, copy) void(^btnRefusedBlock)(void);
@end

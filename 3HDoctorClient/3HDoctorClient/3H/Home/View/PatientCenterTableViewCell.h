//
//  PatientCenterTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PatientListModel.h"

@interface PatientCenterTableViewCell : BaseTableViewCell
//患者头像
@property (nonatomic, strong) UIImageView *imgPatient;
//患者title
@property (nonatomic, strong) UILabel *labTitle;
//患者状况
@property (nonatomic, strong) UILabel *labDetail;
//箭头
@property (nonatomic, strong) UIImageView *imgArrow;

@property (nonatomic, strong) UIView *redView;
//赋值
- (void)confingWithModel:(PatientListModel *)dic;
@end

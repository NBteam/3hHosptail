//
//  LaboratoryTestsTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PatientAssayListModel.h"

@interface LaboratoryTestsTableViewCell : BaseTableViewCell
//化验和检查共用一个
@property (nonatomic, strong) UIImageView *imgLogo;
//
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(PatientAssayListModel *)model;
@end

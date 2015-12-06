//
//  ReviewTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PatientRecheckModel.h"

@interface ReviewTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(PatientRecheckModel *)model;
@end

//
//  AppointDoctorsTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DoctorInfoModel.h"
@interface AppointDoctorsTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (CGFloat)confingWithModel:(NSInteger )dic model:(DoctorInfoModel *)model;
@end

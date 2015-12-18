//
//  MyAppointmentTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyAppointmentRegisteredModel.h"

@interface MyAppointmentTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UIImageView *imgBack;

@property (nonatomic, strong) UIImageView *imgDoctorPic;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UILabel *labTime;

@property (nonatomic, strong) UILabel *labState;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labPrice;
//评价
@property (nonatomic, strong) UIImageView *imgAppraise;

@property (nonatomic, strong) UILabel *labAppraise;

//赋值
- (void)confingWithModel:(MyAppointmentRegisteredModel *)model;

@end

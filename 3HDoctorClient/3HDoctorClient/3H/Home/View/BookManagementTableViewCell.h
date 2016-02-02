//
//  BookManagementTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ReservationListModel.h"

@interface BookManagementTableViewCell : BaseTableViewCell

//患者头像
@property (nonatomic, strong) UIImageView *imgPatient;
//患者title
@property (nonatomic, strong) UILabel *labTitle;
//预约时间
@property (nonatomic, strong) UILabel *labTime;
//状态
@property (nonatomic, strong) UILabel *labState;
//赋值
- (void)confingWithModel:(ReservationListModel *)dic;

@end

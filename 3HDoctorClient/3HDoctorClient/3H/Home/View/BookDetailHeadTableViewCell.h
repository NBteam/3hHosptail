//
//  BookDetailHeadTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "PhoneDetailModel.h"
@interface BookDetailHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgPatientPic;

@property (nonatomic, strong) UILabel *labPatientName;

@property (nonatomic, strong) UILabel *labPatientInfo;

@property (nonatomic, strong) UIImageView *imgArrow;
//赋值
- (void)confingWithModel:(PhoneDetailModel *)dic;

@end

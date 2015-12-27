//
//  ConsultingServicesTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ConsultingUnFinishedModel.h"
@interface ConsultingServicesTableViewCell : BaseTableViewCell
//患者头像
@property (nonatomic, strong) UIImageView *imgPatient;
//患者名字
@property (nonatomic, strong) UILabel *labPatientName;
//患者详情
@property (nonatomic, strong) UILabel *labPatientDetail;
//时间
@property (nonatomic, strong) UILabel *labTime;
//横线
@property (nonatomic, strong) UILabel *labLine;
//描述
@property (nonatomic, strong) UILabel *labDescribe;
//赋值
- (void )confingWithModel:(ConsultingUnFinishedModel *)dic;
@end

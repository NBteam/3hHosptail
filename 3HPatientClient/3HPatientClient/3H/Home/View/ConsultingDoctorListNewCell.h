//
//  ConsultingDoctorListNewCell.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DoctorListModel.h"
#import "AppointExpertListModel.h"

@interface ConsultingDoctorListNewCell : BaseTableViewCell
//背景view
@property (nonatomic, strong) UIView * viewBack;
//橙色view
@property (nonatomic, strong) UIView * viewOrange;
//头像
@property (nonatomic, strong) UIImageView * imgHead;
//名字
@property (nonatomic, strong) UILabel * labName;
//医院
@property (nonatomic, strong) UILabel * labHospital;
//详细内容
@property (nonatomic, strong) UILabel * labDetail;
- (CGFloat)confingWithModel:(DoctorListModel *)model;
- (CGFloat)confingWithAppointExpertListModel:(AppointExpertListModel *)model;
@end

//
//  DiagnosisEditorTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MedicalHistoryEditorTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UIImageView *imgArrow;

//赋值
- (void)confingWithModel:(NSDictionary *)model;
@end

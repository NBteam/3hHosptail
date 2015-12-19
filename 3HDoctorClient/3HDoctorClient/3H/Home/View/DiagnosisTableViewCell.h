//
//  DiagnosisListTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DiagnosisModel.h"
@interface DiagnosisTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UILabel *labTitle;

//赋值
- (void)confingWithModel:(DiagnosisModel *)model;
@end

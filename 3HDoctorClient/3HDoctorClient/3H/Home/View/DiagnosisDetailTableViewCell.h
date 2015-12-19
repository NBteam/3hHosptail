//
//  DiagnosisDetailTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DiagnosisDetailTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labDetail;



//赋值
- (CGFloat)confingWithModel:(NSString *)model;
@end

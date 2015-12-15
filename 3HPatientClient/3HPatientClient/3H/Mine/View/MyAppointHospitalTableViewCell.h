//
//  MyAppointHospitalTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyAppointHospitalTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labTime;

//赋值
- (void)confingWithModel:(NSInteger )index;
@end

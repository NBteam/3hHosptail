//
//  MineHeadTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MineHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgDoctorPic;

@property (nonatomic, strong) UILabel *labDoctorName;

@property (nonatomic, strong) UILabel *labDoctorInfo;

@property (nonatomic, strong) UIButton *btnAttestation;

@property (nonatomic, strong) UIImageView *imgArrow;
//赋值
- (void)confingWithModelOfName:(NSString *)name Hosptail:(NSString *)hosptail Job:(NSString *)job Pic:(NSString *)pic Checked:(NSString *)checked;
@end

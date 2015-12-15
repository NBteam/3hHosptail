//
//  ConsultingDynamicHeadTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "InformationModel.h"
@interface ConsultingDynamicHeadTableViewCell : BaseTableViewCell


@property (nonatomic, strong) UIImageView *imgBack;

@property (nonatomic, strong) UIView *viewBlack;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTime;

//赋值
- (void)confingWithModel:(InformationModel *)dic;

@end

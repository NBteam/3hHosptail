//
//  ConsultingDynamicTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ConsultingDynamicListModel.h"
@interface ConsultingDynamicTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UILabel *labTime;

@property (nonatomic, strong) UIImageView *imgTime;

//赋值
- (void)confingWithModel:(ConsultingDynamicListModel *)dic;

@end

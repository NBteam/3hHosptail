//
//  ConsultingDynamicHeadTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ConsultingDynamicListModel.h"
@interface ConsultingDynamicHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgBack;

@property (nonatomic, strong) UIView *viewBlack;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTime;

//赋值
- (void)confingWithModel:(ConsultingDynamicListModel *)dic;

@end

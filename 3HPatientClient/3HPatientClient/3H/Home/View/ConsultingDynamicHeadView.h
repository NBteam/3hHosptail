//
//  ConsultingDynamicHeadView.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultingDynamicListModel.h"
@interface ConsultingDynamicHeadView : UIView

@property (nonatomic, strong) UIImageView *imgBack;

@property (nonatomic, strong) UIView *viewBlack;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTime;

//赋值
- (void)confingWithModel:(ConsultingDynamicListModel *)dic;

@end

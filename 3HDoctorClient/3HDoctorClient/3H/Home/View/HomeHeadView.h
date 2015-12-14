//
//  HomeHeadView.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeadView : UIView

@property (nonatomic, strong) UIView *viewWhite;

@property (nonatomic, strong) UILabel *labTitle;
//背景图
@property (nonatomic, strong) UIImageView *imgBack;
//头像
@property (nonatomic, strong) UIImageView *imgMyPicture;
//名字
@property (nonatomic, strong) UILabel *labName;
//详细
@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(NSDictionary *)dict;

@end

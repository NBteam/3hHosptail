//
//  DynamicDetailTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"


@interface DynamicDetailTableViewCell : BaseTableViewCell
//标题
@property (nonatomic, strong) UILabel *labTitle;
//作者
@property (nonatomic, strong) UILabel *labAuthor;
//时间
@property (nonatomic, strong) UILabel *labTime;
//img
@property (nonatomic, strong) UIImageView *imgLogo;
//内容
@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UIWebView *webView;
//赋值
- (CGFloat )confingWithModel:(NSDictionary *)dic;

@end

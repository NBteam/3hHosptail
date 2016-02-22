//
//  InviteCodeTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/2/22.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface InviteCodeTableViewCell : BaseTableViewCell


@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labDetail;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, copy) void (^btnBlock)();

//赋值
- (void)confingWithModel:(NSString *)model;
@end

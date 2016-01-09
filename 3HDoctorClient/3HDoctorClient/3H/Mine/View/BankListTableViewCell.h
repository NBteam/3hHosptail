//
//  BankListTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/9.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BankListModel.h"
@interface BankListTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labName;

@property (nonatomic, strong) UIImageView *imgArrow;

//赋值
//赋值
- (void)confingWithModel:(BankListModel *)model;
@end

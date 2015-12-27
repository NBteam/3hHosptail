//
//  WithdrawalTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "WithdrawaListModel.h"
@interface WithdrawalTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgArrow;


//赋值
- (void)confingWithModel:(WithdrawaListModel *)model;

@end

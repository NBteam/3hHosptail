//
//  IncomeRecordTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "IncomeRecordModel.h"

@interface IncomeRecordTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

//赋值
- (void)confingWithModel:(IncomeRecordModel *)model;
@end

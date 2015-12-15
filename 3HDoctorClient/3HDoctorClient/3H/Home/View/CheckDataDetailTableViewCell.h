//
//  CheckDataDetailTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CheckDataDetailModel.h"
@interface CheckDataDetailTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UILabel *labTitle;

//赋值
- (CGFloat)confingWithModel:(CheckDataDetailModel *)model;
@end

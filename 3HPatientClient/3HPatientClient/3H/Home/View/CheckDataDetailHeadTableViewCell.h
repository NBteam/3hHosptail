//
//  CheckDataDetailHeadTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CheckDetailModel.h"

@interface CheckDataDetailHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(NSInteger )dic model:(CheckDetailModel *)model;
@end

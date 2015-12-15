//
//  CheckDataDetailHeadTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CheckDataDetailModel.h"
@interface CheckDataDetailHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(CheckDataDetailModel *)model index:(NSInteger)index;
@end
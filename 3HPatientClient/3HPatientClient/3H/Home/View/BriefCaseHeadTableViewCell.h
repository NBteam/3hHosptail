//
//  BriefCaseHeadTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BriefCaseHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(NSInteger )model Title:(NSString *)title;
@end

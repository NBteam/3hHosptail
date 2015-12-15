//
//  PersonalHeadTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PersonalHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIImageView *imgDoctorPic;
@property (nonatomic, strong) UIImageView *imgArrow;


- (void)confingWithModel:(NSString *)dic;

@end

//
//  MineTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MineTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgArrow;

@property (nonatomic, strong) UILabel *labDetail;

//赋值
//赋值
- (void)confingWithModel:(NSDictionary *)dic Points:(NSString *)points;

@end

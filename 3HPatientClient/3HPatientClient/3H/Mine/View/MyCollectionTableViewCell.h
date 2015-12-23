//
//  MyCollectionTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyCollectionTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIButton *btnCollection;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgStar;

@property (nonatomic, strong) UILabel * labPrice;
//赋值
- (void)confingWithModel:(NSDictionary *)dic;
@end

//
//  ConsultingIsPhoneTitleTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ConsultingIsPhoneTitleTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(NSInteger )dic;
@end

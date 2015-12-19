//
//  PhoneAppointSetTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PhoneAppointSetTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UIImageView *imgArrow;

- (void)confingWithModel:(NSDictionary *)dict;
@end

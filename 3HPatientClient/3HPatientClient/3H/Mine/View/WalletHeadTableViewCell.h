//
//  WalletHeadTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface WalletHeadTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(NSDictionary *)dic;
@end

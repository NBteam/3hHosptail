//
//  ShopDetailCommentsTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CommentsModel.h"

@interface ShopDetailCommentsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;
@property (nonatomic, strong) UIImageView *imgArrow;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (void)confingWithModel:(CommentsModel *)model;
@end

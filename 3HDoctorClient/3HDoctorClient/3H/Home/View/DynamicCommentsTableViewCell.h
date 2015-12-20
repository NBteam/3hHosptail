//
//  DynamicCommentsTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CommentsListModel.h"

@interface DynamicCommentsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labType;

@property (nonatomic, strong) UILabel *labDetail;

//赋值
- (CGFloat)confingWithModel:(CommentsListModel * )dic;
@end

//
//  MessageTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MessageModels.h"
@interface MessageTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UIImageView *imgArrow;

@property (nonatomic, strong) UILabel *labNum;
//赋值

- (void)confingWithDict:(NSMutableDictionary *)dict Index:(NSInteger)index draging:(BOOL)draging;
@end

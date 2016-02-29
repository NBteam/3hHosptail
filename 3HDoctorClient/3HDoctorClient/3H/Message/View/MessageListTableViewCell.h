//
//  MessageListTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/2/29.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MessageListModel.h"
@interface MessageListTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UILabel *labTime;

@property (nonatomic, strong) UILabel *labRead;

//赋值

- (void)confingWithDict:(MessageListModel *)model imgString:(NSString *)imgString;

@end

//
//  MessageListTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 16/3/2.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MessageListsModel.h"
@interface MessageListTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UILabel *labTime;

@property (nonatomic, strong) UILabel *labRead;

//赋值

- (void)confingWithDict:(MessageListsModel *)model imgString:(NSString *)imgString;
@end

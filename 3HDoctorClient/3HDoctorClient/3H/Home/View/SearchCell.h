//
//  SearchCell.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/8.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SearchCell : BaseTableViewCell
@property (nonatomic, retain) UIImageView * imgHead;
@property (nonatomic, retain) UILabel * labTitle;
@property (nonatomic, retain) UILabel * labSex;
@property (nonatomic, strong) UILabel * labInfo;
- (void)configWithModel:(id)model;
@end

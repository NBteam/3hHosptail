//
//  OutpatientAppointTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OutpatientAppointTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UIButton *btnSubmit;

@property (nonatomic, copy) void(^outpatientAppontBlcok)(NSArray *arr);

//赋值
- (CGFloat)confingWithModel:(NSInteger )dic;



@end

//
//  ShopDetailNumTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ShopDetailNumTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIButton *btnReduct;
@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) UILabel *labNum;
@property (nonatomic, copy) void (^changeIndex)(NSString *index);
@end

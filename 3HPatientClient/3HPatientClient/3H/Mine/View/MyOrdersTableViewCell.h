//
//  MyOrdersTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OrderListNewModel.h"

@interface MyOrdersTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labState;

@property (nonatomic, strong) UILabel *labLine1;

@property (nonatomic, strong) UIImageView *imgProduct;

@property (nonatomic, strong) UILabel *labProduct;

@property (nonatomic, strong) UILabel *labSingePrice;

@property (nonatomic, strong) UILabel *labNum;

@property (nonatomic, strong) UILabel *labLine2;

@property (nonatomic, strong) UILabel *labPrice;

@property (nonatomic, strong) UILabel *labLine3;

@property (nonatomic, strong) UIButton *btnDelete;

@property (nonatomic, strong) UIButton *btnAppraise;
//赋值
- (void)confingWithModel:(OrderListNewModel *)dic;

@end

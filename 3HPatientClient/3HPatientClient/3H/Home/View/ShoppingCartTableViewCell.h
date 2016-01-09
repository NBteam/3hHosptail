//
//  ShoppingCartTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/27.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CartListModel.h"

@interface ShoppingCartTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIButton *btnSelect;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labPrice;

@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UIButton *btnReduct;
@property (nonatomic, strong) UIButton *btnAdd;
@property (nonatomic, strong) UILabel *labNum;
@property (nonatomic, copy) void (^addCartNum)(void);
@property (nonatomic, copy) void (^decreaseCartNum)(void);
@property (nonatomic, copy) void (^btnSelectBlock)(BOOL chiose);
- (void)confingWithModel:(CartListModel *)model;

@end

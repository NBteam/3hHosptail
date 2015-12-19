//
//  ShopTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ShopCustomView.h"
#import "GoodsListModel.h"
@interface ShopTableViewCell : BaseTableViewCell
@property (nonatomic, strong) ShopCustomView *customView1;
@property (nonatomic, strong) ShopCustomView *customView2;
@property (nonatomic, copy) void (^customViewBlock)(NSInteger tag);
//赋值
- (void)confingWithModel:(GoodsListModel *)model indexRow:(NSInteger)row;
- (void)hiddenItem;

@end

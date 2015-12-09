//
//  LaboratoryTestsHeadView.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LaboratoryTestsTopView : UIView

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labColorLine;

@property (nonatomic, strong) NSArray *titleArray;
//  设置头部按钮的选中方法
- (void)topButtonMenuSelectForIndex:(NSInteger)index;
- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;
//按钮点击回调
@property (nonatomic,copy) void (^btnClickBlock)(NSInteger index);

@end

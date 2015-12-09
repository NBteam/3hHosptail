//
//  CheckDataTopView.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckDataTopView : UIView

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labColorLine;


//  设置头部按钮的选中方法
- (void)topButtonMenuSelectForIndex:(NSInteger)index;
//按钮点击回调
@property (nonatomic,copy) void (^btnClickBlock)(NSInteger index);

@end

//
//  AllHeadView.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/18.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllHeadView : UIView
@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labColorLine;


//  设置头部按钮的选中方法
- (void)topButtonMenuSelectForIndex:(NSInteger)index;
//按钮点击回调
@property (nonatomic,copy) void (^btnClickBlock)(NSInteger index);
@end

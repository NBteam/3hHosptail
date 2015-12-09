//
//  RecommendScrollViewLoop.h
//  NR
//
//  Created by 范英强 on 15/8/17.
//  Copyright (c) 2015年 范英强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendScrollViewLoop : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;
@property (nonatomic, strong) UIView *pointView;
@property (nonatomic , assign) NSInteger currentPageIndex;
/**
 数据源：获取总的page个数
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);
/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
//获取当前在哪个页面
@property (nonatomic , copy) void (^GetViewIndexBlock)(NSInteger pageIndex);
/**
 当点击的时候，执行的block
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);
//暂停
- (void)recommendScrollViewPauseTimer;
//开始
- (void)recommendScrollViewResumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
